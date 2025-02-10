package handler

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	"github.com/rensawamo/dart-go-grpc-connect/backend/domain"
	elizav1 "github.com/rensawamo/dart-go-grpc-connect/backend/gen/eliza/v1"
)

type ElizaHandler struct {
	elizaUsecase domain.ElizaUsecase
}

func NewElizaHandler(usecase domain.ElizaUsecase) *ElizaHandler {
	return &ElizaHandler{
		elizaUsecase: usecase,
	}
}

func (h *ElizaHandler) Say(ctx context.Context, req *connect.Request[elizav1.SayRequest]) (*connect.Response[elizav1.SayResponse], error) {
	// ランダムな文章をユースケースから取得
	sentence, err := h.elizaUsecase.FetchSentence(ctx)
	if err != nil {
		return nil, connect.NewError(connect.CodeInternal, fmt.Errorf("failed to fetch sentence: %w", err))
	}

	if sentence.Sentence == "" {
		return nil, connect.NewError(connect.CodeNotFound, fmt.Errorf("no sentences found"))
	}

	response := &elizav1.SayResponse{
		Sentence: sentence.Sentence,
	}

	return connect.NewResponse(response), nil
}
