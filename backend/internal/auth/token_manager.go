package auth

import (
	"errors"
	"os"
	"time"

	"github.com/lestrrat-go/jwx/v2/jwa"
	"github.com/lestrrat-go/jwx/v2/jwe"
	"github.com/lestrrat-go/jwx/v2/jwk"
	"github.com/lestrrat-go/jwx/v2/jwt"
)

type TokenManager struct {
	// 署名アルゴリズム
	signAlg jwa.SignatureAlgorithm

	// 暗号化アルゴリズム
	encryptAlg jwa.KeyEncryptionAlgorithm

	// RSA秘密鍵
	privateKey jwk.RSAPrivateKey

	// 署名元の名前
	issuer string
}

// トークンマネージャーの作成
func NewTokenManager(issuer string, keyPath string) (*TokenManager, error) {
	if issuer == "" || keyPath == "" {
		return nil, errors.New("error: invalid parameter")
	}

	// RSA秘密鍵ファイル(PEM形式)を読み込む
	src, err := os.ReadFile(keyPath)
	if err != nil {
		return nil, errors.New("error: failed to read private-key-file")
	}

	// 秘密鍵をPEM形式からJWKに変換する
	key, err := jwk.ParseKey(src, jwk.WithPEM(true))
	if err != nil {
		return nil, errors.New("error: failed to parse pem file")
	}

	var jwkPrivateKey jwk.RSAPrivateKey
	var ok bool
	if jwkPrivateKey, ok = key.(jwk.RSAPrivateKey); !ok {
		return nil, errors.New("error: failed to parse jwk-private-key from rsa-private-key")
	}

	return &TokenManager{
		signAlg:    jwa.RS256,
		encryptAlg: jwa.RSA_OAEP,
		issuer:     issuer,
		privateKey: jwkPrivateKey,
	}, nil
}

// アクセストークンの作成
func (m *TokenManager) CreateAccessToken(userID []byte, duration time.Duration) (string, error) {
	if len(userID) == 0 {
		return "", errors.New("error: invalid token parameter")
	}

	// 秘密鍵から公開鍵を取得する
	publicKey, err := m.privateKey.PublicKey()
	if err != nil {
		return "", err
	}

	now := time.Now().UTC()

	// トークンに情報を含める
	token, err := jwt.NewBuilder().
		Issuer(m.issuer).
		IssuedAt(now).
		Subject(string(userID)).
		Expiration(now.Add(duration)).
		Build()
	if err != nil {
		return "", err
	}

	// 秘密鍵を使用してトークンの署名を行う
	signed, err := jwt.Sign(token, jwt.WithKey(m.signAlg, m.privateKey))
	if err != nil {
		return "", err
	}

	// 公開鍵を使用して暗号化を行う
	encrypted, err := jwe.Encrypt(signed, jwe.WithKey(m.encryptAlg, publicKey))
	if err != nil {
		return "", err
	}

	return string(encrypted), nil
}

// トークンからユーザーIDを取得する
func (m *TokenManager) GetUserID(token string) ([]byte, error) {
	// 秘密鍵から公開鍵を取得する
	publicKey, err := m.privateKey.PublicKey()
	if err != nil {
		return nil, err
	}

	// 秘密鍵を使用して復号化を行う
	decrypted, err := jwe.Decrypt([]byte(token), jwe.WithKey(m.encryptAlg, m.privateKey))
	if err != nil {
		return nil, errors.New("error: failed to decrypt token")
	}

	// 公開鍵を使用してトークンの署名を検証する
	parsedToken, err := jwt.Parse(decrypted, jwt.WithKey(m.signAlg, publicKey))
	if err != nil {
		return nil, errors.New("error: failed to verify token")
	}

	// トークンからユーザーIDを取得する
	subject := parsedToken.Subject()
	if subject == "" {
		return nil, errors.New("error: user ID (subject) is missing in token")
	}

	return []byte(subject), nil
}
