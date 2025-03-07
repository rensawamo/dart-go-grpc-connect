package repository

import (
	"context"
	"database/sql"
	"log"
	"math/rand"

	"github.com/google/uuid"
	"github.com/rensawamo/dart-go-grpc-connect/backend/domain"
	"github.com/rensawamo/dart-go-grpc-connect/backend/gen/models"
	"github.com/volatiletech/sqlboiler/v4/boil"
)

type elizaRepository struct {
	database *sql.DB
}

func NewElizaRepository(db *sql.DB) domain.ElizaRepository {
	return &elizaRepository{
		database: db,
	}
}

func (er *elizaRepository) CreateSentence(c context.Context, sentence string) error {
	id := uuid.New()

	modelSentence := &models.Sentence{
		ID:       id[:],
		Sentence: sentence,
	}

	// トランザクションの開始
	tx, err := er.database.BeginTx(c, nil)
	if err != nil {
		return err
	}
	defer func() {
		if err := tx.Rollback(); err != nil && err != sql.ErrTxDone {
			log.Printf("failed to rollback transaction: %v", err)
		}
	}()
	if err := modelSentence.Insert(c, tx, boil.Infer()); err != nil {
		return err
	}

	return tx.Commit()
}

// DBからランダムに1つのセンテンスを取得する
func (er *elizaRepository) FetchSentence(c context.Context) (domain.Eliza, error) {
	modelSentences, err := models.Sentences().All(c, er.database)
	if err != nil {
		return domain.Eliza{}, err
	}

	if len(modelSentences) == 0 {
		return domain.Eliza{}, nil
	}
	randomIndex := rand.Intn(len(modelSentences))
	selectedSentence := modelSentences[randomIndex]

	return domain.Eliza{
		ID:       selectedSentence.ID,
		Sentence: selectedSentence.Sentence,
	}, nil
}
