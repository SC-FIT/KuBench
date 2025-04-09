FROM golang:1.22

WORKDIR /app

COPY . .
RUN go mod download

RUN go build -o main main.go

EXPOSE 8081

CMD ["./main"]