package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"github.com/rensawamo/dart-go-grpc-connect/backend/di"
	"github.com/rensawamo/dart-go-grpc-connect/backend/gen/auth/v1/authv1connect"

	"github.com/rs/cors"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"

	"github.com/volatiletech/sqlboiler/v4/boil"
)

func main() {
	boil.DebugMode = true
	dsn := getEnvOrPanic("DSN")
	db, err := sql.Open("mysql", dsn)
	dieIf(err)
	defer db.Close()

	// データベースの接続確認
	err = db.Ping()
	dieIf(err)
	fmt.Println("Connected to database")

	// 環境変数の取得
	issuer := getEnvOrPanic("REPO_NAME")
	keyPath := getEnvOrPanic("PRIVATE_KEY_PATH")

	// インターセプタの設定
	// authInterceptor := connect.WithInterceptors(interceptor.NewAuthInterceptor(issuer, keyPath))
	timeout := 1 * time.Hour
	mux := http.NewServeMux()

	loginHandler, err := di.InitLoginHandler(db, issuer, keyPath, timeout)
	dieIf(err)

	mux.Handle(authv1connect.NewAuthServiceHandler(loginHandler))

	address := "localhost:8080"
	fmt.Printf("Starting server at %s\n", address)
	err = http.ListenAndServe(
		address,
		cors.AllowAll().Handler(
			h2c.NewHandler(mux, &http2.Server{}),
		),
	)
	dieIf(err)
}

func getEnvOrPanic(key string) string {
	value, ok := os.LookupEnv(key)
	if !ok {
		panic(fmt.Sprintf("Environment variable %s not set", key))
	}
	return value
}

func dieIf(err error) {
	if err != nil {
		log.Fatalf("Fatal error: %v", err)
	}
}
