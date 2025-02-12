package domain

import (
	"context"
)

type Eliza struct {
	ID       []byte `bson:"_id"`
	Sentence string `bson:"title" form:"title" binding:"required" json:"title"`
}

type ElizaRepository interface {
	CreateSentence(c context.Context, sentence string) error
	FetchSentence(c context.Context) (Eliza, error)
}

type ElizaUsecase interface {
	CreateSentence(c context.Context, eliza *Eliza) error
	FetchSentence(c context.Context) (Eliza, error)
}
