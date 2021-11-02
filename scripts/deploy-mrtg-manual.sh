#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
sudo apt-get update -y
sudo apt-get install apache2 snmp snmpd -y

#adjust line number before proceeding
sed -i -e '70i\' -e 'rocommunity  public localhost' /etc/snmp/snmpd.conf 

sudo systemctl restart snmpd

sudo apt-get install mrtg -y

sudo mkdir -p /var/www/html/mrtg

sudo sed -i.bck 's/^WorkDir: \/var\/www\/mrtg/WorkDir: \/var\/www\/html\/mrtg/' /etc/mrtg.cfg

sudo sh -c 'cfgmaker public@localhost > /etc/mrtg.cfg'

sudo sh -c 'indexmaker /etc/mrtg.cfg > /var/www/html/mrtg/index.html'

curl http://localhost/mrtg/