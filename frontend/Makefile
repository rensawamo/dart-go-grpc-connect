.PHONY: gen
gen:
	buf generate -v --debug --include-imports --include-wkt \
	"https://github.com/rensawamo/dart-go-grpc-connect#format=git,subdir=proto" \

.PHONY: br
br:
	flutter pub run build_runner build --delete-conflicting-outputs