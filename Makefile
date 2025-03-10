
help: ## show this message
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-8s\033[0m %s\n", $$1, $$2}'

breaking: ## buf breaking
	buf breaking --against '.git#subdir=proto'

mod-update: dep-update

dep-update: ## buf dep update
	buf dep update

deps: ## install dependencies
	env GOBIN="$(PWD)/tmp/bin" go install github.com/bufbuild/buf/cmd/buf@v1.33.0