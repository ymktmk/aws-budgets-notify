#!/bin/bash
go get -v
# ビルド環境がダメ
GOOS=linux go build -v ../main.go
zip function.zip main
rm main