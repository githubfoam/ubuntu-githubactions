IMAGE := alpine/fio
APP:="scripts/archlinux-req.sh"

deploy-kafl:
	bash scripts/deploy-kafl.sh

deploy-radamsa:
	bash scripts/deploy-radamsa.sh

deploy-tshark:
	bash scripts/deploy-tshark.sh

deploy-ncpa:
	bash scripts/deploy-ncpa.sh

deploy-mrtg:
	bash scripts/deploy-mrtg.sh

deploy-nipap:
	bash scripts/deploy-nipap.sh

deploy-snmpv3:
	bash scripts/deploy-snmpv3.sh

virtualenv-ansible-specific:
	bash scripts/virtualenv-ansible-specific.sh

virtualenv-ansible:
	bash scripts/virtualenv-ansible.sh

deploy-osquery:
	bash scripts/install_osquery.sh

dfir-osquery:
	bash scripts/dfir_osquery.sh

push-image:
	docker push $(IMAGE)

.PHONY: deploy-vagrant deploy-libvirt deploy-zabbix push-image
