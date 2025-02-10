package main

import (
	"database/sql"
	"fmt"
	"os"

	_ "github.com/go-sql-driver/mysql"
    
	"github.com/volatiletech/sqlboiler/v4/boil"
)

func main() {
	boil.DebugMode = true
	dsn, ok := os.LookupEnv("DSN")
	dieFalse(ok, "env DSN not found")
	db, err := sql.Open("mysql", dsn)
	dieIf(err)
	err = db.Ping()
	dieIf(err)
	fmt.Println("connected")
}

func dieFalse(ok bool, msg string) {
	if !ok {
		panic(msg)
	}
}
func dieIf(err error) {
	if err != nil {
		panic(err)
	}
}
