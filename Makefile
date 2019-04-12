.DEFAULT_GOAL := help

all: test destroy ## Test and destroy

clean: ## Remove local working files
	rm -rf .kitchen

init:
	bundle install

update:
	bundle update

test: create converge setup verify ## Set up all the stuff and run tests

create: init
	kitchen create

converge: create
	kitchen converge

setup: converge ## Set up all the stuff, but don't run the tests
	kitchen setup

verify: ## Just run the tests, assume everything is set up already
	kitchen verify

destroy: init ## Tear down the things
	kitchen destroy

help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
