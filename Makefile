.PHONY: gen
gen:
	cd backend && make gen && cd ../frontend && make gen

BASE_URL = http://localhost:8080
LOGIN_URL = $(BASE_URL)/auth.v1.AuthService/Login
SAY_URL = $(BASE_URL)/eliza.v1.ElizaService/Say
CREATE_SENTENCE_URL = $(BASE_URL)/eliza.v1.ElizaService/CreateSentence

EMAIL = test@google.com
PASSWORD = example

ACCESS_TOKEN := $(shell curl --silent --header "Content-Type: application/json" \
  --data '{"email": "$(EMAIL)", "password": "$(PASSWORD)"}' \
  $(LOGIN_URL) | jq -r '.token')

.PHONY: login
login:
	@echo "Getting access token..."
	@echo "ACCESS_TOKEN=$(ACCESS_TOKEN)"  && echo "\n"

.PHONY: say
say:
	@echo "Making request to 'Say' endpoint..."
	curl --header "Authorization: Bearer $(ACCESS_TOKEN)" \
	--header "Content-Type: application/json" \
	--data '{}' \
	$(SAY_URL) && echo "\n"

.PHONY: all
all: login say 

.PHONY: create_sentence
create_sentence:
	@echo "Making request to 'CreateSentence' endpoint with input: $(input)"
	curl --header "Authorization: Bearer $(ACCESS_TOKEN)" \
	--header "Content-Type: application/json" \
	--data '{"input": "$(input)"}' \
	$(CREATE_SENTENCE_URL) && echo "\n"


