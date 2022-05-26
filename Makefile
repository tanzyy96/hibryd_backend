-include .env
export

start:
	go run server.go

gql-gen:
	go run github.com/99designs/gqlgen generate

migrate-create:
	migrate create -ext sql -dir db/migrations -seq $(name)

migrate-up:
	migrate -database postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DBNAME}?sslmode=disable -path db/migrations up

migrate-down:
	migrate -database postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DBNAME}?sslmode=disable -path db/migrations down

migrate-force:
	migrate -database postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DBNAME}?sslmode=disable -path db/migrations force $(ver)