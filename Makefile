.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:

KUBECONFIG = $(shell pwd)/kubeconfig.yaml
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: bootstrap terraform smoke-test post-install

configure:
	./scripts/configure
	git status

bootstrap:
	make -C bootstrap

terraform:
	make -C terraform

smoke-test:
	make -C test filter=Smoke

post-install:
	@./scripts/hacks

tools:
	@docker run \
		--rm \
		--interactive \
		--tty \
		--network host \
		--env "KUBECONFIG=${KUBECONFIG}" \
		--volume "/var/run/docker.sock:/var/run/docker.sock" \
		--volume $(shell pwd):$(shell pwd) \
		--volume ${HOME}/.ssh:/root/.ssh \
		--volume ${HOME}/.terraform.d:/root/.terraform.d \
		--volume homelab-tools-cache:/root/.cache \
		--volume homelab-tools-nix:/nix \
		--workdir $(shell pwd) \
		docker.io/nixos/nix nix --experimental-features 'nix-command flakes' develop

test:
	make -C test


docs:
	mkdocs serve

git-hooks:
	pre-commit install
