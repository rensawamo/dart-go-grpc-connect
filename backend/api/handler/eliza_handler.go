package handler

import (
	"context"
	"fmt"

	"github.com/bufbuild/connect-go"
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

func (h *ElizaHandler) CreateSentence(ctx context.Context, req *connect.Request[elizav1.CreateSentenceRequest]) (*connect.Response[elizav1.CreateSentenceResponse], error) {
	// リクエストからセンテンスを取得
	sentence := req.Msg.Input

	// ユースケースにセンテンスを保存
	err := h.elizaUsecase.CreateSentence(ctx, &domain.Eliza{Sentence: sentence})
	if err != nil {
		return nil, connect.NewError(connect.CodeInternal, fmt.Errorf("failed to create sentence: %w", err))
	}

	return connect.NewResponse(&elizav1.CreateSentenceResponse{
		Sentence: sentence,
	}), nil
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
