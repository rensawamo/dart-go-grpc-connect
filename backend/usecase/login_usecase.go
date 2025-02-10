package usecase

import (
	"context"
	"time"

	"github.com/rensawamo/dart-go-grpc-connect/backend/domain"
	"github.com/rensawamo/dart-go-grpc-connect/backend/internal/auth"
)

type loginUsecase struct {
	userRepository domain.UserRepository
	contextTimeout time.Duration
	tokenManager   *auth.TokenManager
}

func NewLoginUsecase(userRepository domain.UserRepository, timeout time.Duration, tokenManager *auth.TokenManager) domain.LoginUsecase {
	return &loginUsecase{
		userRepository: userRepository,
		contextTimeout: timeout,
		tokenManager:   tokenManager,
	}
}

func (lu *loginUsecase) GetUserByEmail(c context.Context, email string) (domain.User, error) {
	ctx, cancel := context.WithTimeout(c, lu.contextTimeout)
	defer cancel()
	return lu.userRepository.GetByEmail(ctx, email)
}

func (lu *loginUsecase) CreateAccessToken(user *domain.User, secret string, expiry int) (string, error) {
	return lu.tokenManager.CreateAccessToken(user.ID, time.Duration(expiry)*time.Minute)
}
