#!/bin/bash
go get -v

GOARCH=amd64 GOOS=linux go build ../main.go

zip function.zip main

rm main