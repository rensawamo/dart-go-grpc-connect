package usecase

import (
	"context"
	"errors"

	"github.com/rensawamo/dart-go-grpc-connect/backend/domain"
)

type elizaUsecase struct {
	repo domain.ElizaRepository
}

func NewElizaUsecase(repo domain.ElizaRepository) domain.ElizaUsecase {
	return &elizaUsecase{
		repo: repo,
	}
}

func (uc *elizaUsecase) CreateSentence(ctx context.Context, eliza *domain.Eliza) error {
	if eliza.Sentence == "" {
		return errors.New("sentence cannot be empty")
	}
	return uc.repo.CreateSentence(ctx, eliza.Sentence)
}

func (uc *elizaUsecase) FetchSentence(ctx context.Context) (domain.Eliza, error) {
	sentence, err := uc.repo.FetchSentence(ctx)
	if err != nil {
		return domain.Eliza{}, err
	}

	if sentence.ID == nil || sentence.Sentence == "" {
		return domain.Eliza{}, errors.New("no sentence found")
	}

	return sentence, nil
}
