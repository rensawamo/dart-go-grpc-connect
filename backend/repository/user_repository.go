package repository

import (
	"context"
	"database/sql"
	"log"

	"github.com/rensawamo/dart-go-grpc-connect/backend/domain"
	"github.com/rensawamo/dart-go-grpc-connect/backend/gen/models"
	"github.com/volatiletech/sqlboiler/v4/boil"
	"github.com/volatiletech/sqlboiler/v4/queries/qm"
)

type userRepository struct {
	database *sql.DB
}

func NewUserRepository(db *sql.DB) domain.UserRepository {
	return &userRepository{
		database: db,
	}
}

// Create 新しいユーザーをデータベースに挿入する
func (ur *userRepository) Create(ctx context.Context, user *domain.User) error {
	modelUser := &models.User{
		ID:       user.ID,
		Email:    user.Email,
		Password: user.Password,
	}

	// トランザクションの開始
	tx, err := ur.database.BeginTx(ctx, nil)
	if err != nil {
		return err
	}
	defer func() {
		if err := tx.Rollback(); err != nil && err != sql.ErrTxDone {
			log.Printf("failed to rollback transaction: %v", err)
		}
	}()

	// ユーザーを挿入
	if err := modelUser.Insert(ctx, tx, boil.Infer()); err != nil {
		return err
	}

	return tx.Commit()
}

// Fetch 全てのユーザーを取得する
func (ur *userRepository) Fetch(ctx context.Context) ([]domain.User, error) {
	modelUsers, err := models.Users().All(ctx, ur.database)
	if err != nil {
		return nil, err
	}

	var users []domain.User
	for _, modelUser := range modelUsers {
		users = append(users, domain.User{
			ID:       modelUser.ID,
			Email:    modelUser.Email,
			Password: modelUser.Password,
		})
	}

	return users, nil
}

// GetByEmail メールアドレスからユーザーを取得する
func (ur *userRepository) GetByEmail(ctx context.Context, email string) (domain.User, error) {
	modelUser, err := models.Users(qm.Where("email = ?", email)).One(ctx, ur.database)
	if err != nil {
		return domain.User{}, err
	}

	return domain.User{
		ID:       modelUser.ID,
		Email:    modelUser.Email,
		Password: modelUser.Password,
	}, nil
}

// GetByID ユーザーIDからユーザーを取得する
func (ur *userRepository) GetByID(ctx context.Context, id string) (domain.User, error) {
	modelUser, err := models.Users(qm.Where("id = ?", id)).One(ctx, ur.database)
	if err != nil {
		return domain.User{}, err
	}

	return domain.User{
		ID:       modelUser.ID,
		Email:    modelUser.Email,
		Password: modelUser.Password,
	}, nil
}
