package handler

import (
	"context"
	"errors"

	"connectrpc.com/connect"
	"github.com/rensawamo/dart-go-grpc-connect/backend/domain"
	authv1 "github.com/rensawamo/dart-go-grpc-connect/backend/gen/auth/v1"
)

type LoginHandler struct {
	loginUsecase      domain.LoginUsecase
	secret            string
	accessTokenExpiry int
}

func NewLoginHandler(loginUsecase domain.LoginUsecase, accessTokenExpiry int) *LoginHandler {
	return &LoginHandler{
		loginUsecase: loginUsecase,

		accessTokenExpiry: accessTokenExpiry,
	}
}

func (h *LoginHandler) Login(ctx context.Context, req *connect.Request[authv1.LoginRequest]) (*connect.Response[authv1.LoginResponse], error) {
	// ログインリクエストの取得
	loginReq := req.Msg

	// ユーザー情報の取得
	user, err := h.loginUsecase.GetUserByEmail(ctx, loginReq.Email)
	if err != nil {
		return nil, connect.NewError(connect.CodeUnauthenticated, errors.New("user not found"))
	}
	if user.Password != loginReq.Password {
		return nil, connect.NewError(connect.CodeUnauthenticated, errors.New("invalid email or password"))
	}
	// アクセストークンの生成
	accessToken, err := h.loginUsecase.CreateAccessToken(&user, h.secret, h.accessTokenExpiry)
	if err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	// レスポンスの作成
	response := &authv1.LoginResponse{
		Token: accessToken,
	}
	return connect.NewResponse(response), nil
}
