package interceptor

import (
	"context"
	"errors"
	"strings"

	"connectrpc.com/connect"
	"github.com/rensawamo/dart-go-grpc-connect/backend/internal/auth"
	"github.com/rensawamo/dart-go-grpc-connect/backend/internal/contextkey"
)

// リクエストのJWTを検証し、成功時にはUserIDをコンテキストにセットする
func NewAuthInterceptor(issuer string, keyPath string) connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return connect.UnaryFunc(func(ctx context.Context, req connect.AnyRequest) (connect.AnyResponse, error) {

			authHeader := req.Header().Get("Authorization")
			if authHeader == "" {
				return nil, connect.NewError(connect.CodeUnauthenticated, errors.New("missing authorization header"))
			}

			token := strings.TrimSpace(strings.TrimPrefix(authHeader, "Bearer"))
			if token == "" {
				return nil, connect.NewError(connect.CodeUnauthenticated, errors.New("empty token after trimming"))
			}

			tm, err := auth.NewTokenManager(issuer, keyPath)
			if err != nil {
				return nil, connect.NewError(connect.CodeInternal, errors.New("failed to initialize token manager"))
			}

			userID, err := tm.GetUserID(token)
			if err != nil {
				return nil, connect.NewError(connect.CodeUnauthenticated, errors.New("invalid or expired token"))
			}

			cw := contextkey.NewContextWriter()
			ctx = cw.SetUserID(ctx, userID)

			return next(ctx, req)
		})
	}
	return connect.UnaryInterceptorFunc(interceptor)
}
