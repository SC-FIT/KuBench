# Gin experiment
Experimental project in Gin to create a REST API.

## Requirements
- Go
- Docker
- Postgres

## Run application
0. Clone the repository and go to the project folder
1. Install dependencies
    ```shell
    go mod tidy
    ```
2. Run the database
```shell
docker compose up postgres
```

3. Run the application
```shell
go run main.go
```

The application runs on port 8081.

## Run using docker
    