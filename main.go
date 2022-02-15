package main

import (
	"context"
	"log"
	"github.com/aws/aws-lambda-go/lambda"
)

type RawHandler struct {
}

func (h *RawHandler) Invoke(ctx context.Context, payload []byte) ([]byte, error) {
	log.Println("---payload start---")
	log.Println(string(payload))
	log.Println("--- payload end ---")
	return []byte("completed"), nil
}

func main() {
	lambda.StartHandler(&RawHandler{})
}