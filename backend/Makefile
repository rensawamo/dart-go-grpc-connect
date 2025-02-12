SQL_MIGRATE_CLI		= sql-migrate
 
.PHONY: run
run:
	go run cmd/main.go

.PHONY: gen
gen:
	buf generate -v --debug --include-imports --include-wkt \
	"https://github.com/rensawamo/dart-go-grpc-connect#format=git,subdir=proto" \

.PHONY: up
up:
	docker compose -f database/docker-compose.yml up --force-recreate

.PHONY: down
down:
	docker compose -f database/docker-compose.yml down

boiler-gen:
	sqlboiler mysql

migrate-up:	
	$(SQL_MIGRATE_CLI) up --config dbconfig.yml

migrate-down:	
	$(SQL_MIGRATE_CLI) down --config dbconfig.yml

migrate-status:	
	$(SQL_MIGRATE_CLI)  status --config dbconfig.yml
