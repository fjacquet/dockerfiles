IMAGES := consul esxicompcheck httpd mariadb ntp percona postfix powershell snmp uemcli vnxcli wordpress
HADOLINT := hadolint

# lint-% and build-% are deliberately absent here: make never searches implicit
# or pattern rules for a target declared .PHONY, so listing them made every
# `make lint` / `make build` report "Nothing to be done" and silently do zero
# work. .SECONDARY has the same "always out of date" effect without that.
.PHONY: all lint build clean help
.SECONDARY:

all: lint

help:
	@echo "Available targets:"
	@echo "  lint          - Lint all Dockerfiles with hadolint"
	@echo "  lint-<image>  - Lint a specific Dockerfile"
	@echo "  build         - Build all Docker images"
	@echo "  build-<image> - Build a specific Docker image"
	@echo "  clean         - Remove all built Docker images"

lint: $(addprefix lint-,$(IMAGES))

lint-%:
	@$(HADOLINT) $*/Dockerfile && echo "$*/Dockerfile: OK"

build: $(addprefix build-,$(IMAGES))

build-%:
	docker build -t $* --rm $*/

clean:
	@$(foreach img,$(IMAGES),docker rmi -f $(img) 2>/dev/null || true;)
