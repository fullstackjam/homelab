.POSIX:

export KUBECONFIG = $(shell pwd)/../kubeconfig.yaml

.PHONY: default bootstrap helm-diff-check install-helmfile patch_svc

default: bootstrap patch_svc

helm-diff-check:
	@helm plugin list | grep -q diff || helm plugin install https://github.com/databus23/helm-diff

bootstrap: helm-diff-check install-helmfile

install-helmfile:
	@echo "Installing Helmfile..."
	@helmfile apply

patch_svc:
	kubectl patch svc longhorn-frontend -n longhorn -p '{"spec": {"type": "LoadBalancer"}}'
