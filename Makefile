IMG="kiro-cli"
PORT="80"
BUILD=`date +%FT%T%z`
LDFLAGS=-ldflags "-X main.Version=${VERSION} -X main.Build=${BUILD}"

.PHONY: help
help:   ## - Show help message
	@printf "\033[32m\xE2\x9c\x93 usage: make [target]\n\n\033[0m"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build:  ## - Build the ${IMG} image
	@printf "\033[32m\xE2\x9c\x93 Build the ${IMG} image\n\033[0m"
	export DOCKER_CONTENT_TRUST=1 && buildah bud -t localhost/${IMG} .

.PHONY: run
run:    ## - Run the secured image
	@printf "\033[32m\xE2\x9c\x93 Run build ${IMG} image\n\033[0m"
	@mkdir -p /opt/kiro ~/.aws/sso/cache
	@podman run --name kiro-cli -d -v ~/.aws/sso/cache:/home/quser/.aws/sso/cache -v /opt/kiro:/workspace localhost/kiro-cli

.PHONY: clean
clean:  ## - Clean the image
	@bash /opt/kiro/sbin/clean ${IMG}

