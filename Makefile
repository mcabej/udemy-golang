postgres: 
	docker run --name postgres -e POSTGRES_PASSWORD=root -e POSTGRES_USER=root -p 5433:5432 -d postgres

createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres dropdb --if-exists simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:root@localhost:5433/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:root@localhost:5433/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server: 
	go run main.go

.PHONY: createdb dropdb postgres migrateup migratedown sqlc test server
