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
