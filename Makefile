.PHONY: gen
gen:
	cd backend && make gen && cd ../frontend && make gen