IMG := kiro
PORT := 80
BUILD := $(shell date +%FT%T%z)

.PHONY: help
help: ## - Show help message
	@printf "\033[32m\xE2\x9c\x93 usage: make [target]\n\n\033[0m"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## - Build the $(IMG) image
	@printf "\033[32m\xE2\x9c\x93 Build the $(IMG) image\n\033[0m"
	@DOCKER_CONTENT_TRUST=1 buildah bud -t localhost/$(IMG) .

.PHONY: run
run: ## - Run the secured image
	@printf "\033[32m\xE2\x9c\x93 Run $(IMG) image\n\033[0m"
	@mkdir -p data ~/.aws/sso/cache
	@podman run --name $(IMG) -d \
	-u $$(id -u):$$(id -g) \
	-v $$HOME/.aws/sso/cache:/home/quser/.aws/sso/cache \
	localhost/$(IMG)

.PHONY: clean
clean: ## - Clean the image
	@bash /opt/kiro/sbin/clean $(IMG)

