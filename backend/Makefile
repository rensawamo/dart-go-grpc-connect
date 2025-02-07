.PHONY: gen
gen:
	buf generate -v --debug --include-imports --include-wkt \
	"https://github.com/rensawamo/dart-go-grpc-connect#format=git,subdir=proto" \

go-gen: 
	go generate

boiler-gen:
	sqlboiler mysql

# sql-migrate targets
migrate-up:	## migrate up
	$(SQL_MIGRATE_CLI) up --config ../dbconfig.yml

# sql-migrate targets
migrate-down:	## migrate down
	$(SQL_MIGRATE_CLI) down --config ../dbconfig.yml

migrate-status:	## migrate status
	$(SQL_MIGRATE_CLI)  status --config ../dbconfig.yml


deps: ## install dependencies
	go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.1
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2.0
	go install github.com/envoyproxy/protoc-gen-validate@v0.9.0
	go install connectrpc.com/connect/cmd/protoc-gen-connect-go@v1.11.1
	go install github.com/bufbuild/buf/cmd/buf@v1.15.0