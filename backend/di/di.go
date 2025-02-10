package di

import (
	"database/sql"
	"time"

	"github.com/rensawamo/dart-go-grpc-connect/backend/api/handler"
	"github.com/rensawamo/dart-go-grpc-connect/backend/internal/auth"
	"github.com/rensawamo/dart-go-grpc-connect/backend/repository"
	"github.com/rensawamo/dart-go-grpc-connect/backend/usecase"
)

func InitLoginHandler(db *sql.DB, issuer string, keyPath string, timeout time.Duration) (*handler.LoginHandler, error) {
	tokenManager, err := auth.NewTokenManager(issuer, keyPath)
	if err != nil {
		return nil, err
	}

	userRepo := repository.NewUserRepository(db)
	loginUsecase := usecase.NewLoginUsecase(userRepo, time.Minute*5, tokenManager)

	return handler.NewLoginHandler(loginUsecase, int(timeout)), nil
}
