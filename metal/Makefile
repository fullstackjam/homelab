.POSIX:

env ?= prod
export KUBECONFIG = $(shell pwd)/kubeconfig.yaml

default: boot cluster helm-chart

boot: ~/.ssh/id_rsa
	ansible-playbook \
		--inventory inventories/${env}.yml \
		boot.yml

cluster:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		cluster.yml

helm-chart:
	make -C helm

console:
	ansible-console \
		--inventory inventories/${env}.yml
