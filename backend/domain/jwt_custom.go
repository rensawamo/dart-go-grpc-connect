package domain

import (
	"github.com/golang-jwt/jwt/v4"
)

type JwtCustomClaims struct {
	Name string `json:"name"`
	ID   []byte `json:"id"`
	jwt.StandardClaims
}

type JwtCustomRefreshClaims struct {
	ID []byte `json:"id"`
	jwt.StandardClaims
}
