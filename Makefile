
help: ## show this message
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-8s\033[0m %s\n", $$1, $$2}'

lint: ## buf lint
	buf lint

format: ## buf format
	buf format -w

breaking: ## buf breaking
	buf breaking --against '.git#subdir=proto'

mod-update: dep-update

dep-update: ## buf dep update
	buf dep update
