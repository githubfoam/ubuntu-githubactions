IMAGE := alpine/fio
APP:="scripts/archlinux-req.sh"


virtualenv-ansible:
	bash scripts/virtualenv-ansible.sh

deploy-osquery:
	bash scripts/install_osquery.sh

dfir-osquery:
	bash scripts/dfir_osquery.sh

push-image:
	docker push $(IMAGE)

.PHONY: deploy-vagrant deploy-libvirt deploy-zabbix push-image
