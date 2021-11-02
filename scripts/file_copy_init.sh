#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script


echo "===============================let others write====================================================="
mkdir -p /etc/mrtg
chmod o+w /etc/mrtg /etc/cron.d /etc/snmp /etc/apache2 # let others write

chmod o+w /etc/snmp/snmpd.conf # overwriting
chmod o+w /etc/apache2/apache2.conf  # overwriting

echo "===================================================================================="
