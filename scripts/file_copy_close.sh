#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script


echo "===============================close the box====================================================="
chmod o-w /etc/mrtg /etc/cron.d /etc/snmp /etc/apache2 # do not let others write

chmod o-w /etc/snmp/snmpd.conf # do not let others write
chmod o-w /etc/apache2/apache2.conf  # do not let others write
echo "===================================================================================="
echo "verify MIB config entries in snmpd.conf...."
cat /etc/snmp/snmpd.conf | grep localhost
cat /etc/snmp/snmpd.conf | grep disk
echo "===================================================================================="
echo "===================================================================================="
echo "verify MRTG apache2 virtual host snmpd.conf...."
cat /etc/apache2/apache2.conf | grep mrtg 
echo "===================================================================================="
echo "===================================================================================="
echo "verify mrtf cfgs files...."
ls -laid /etc/mrtg /etc/cron.d # dir checks
ls -lai /etc/mrtg /etc/cron.d
echo "===================================================================================="
echo "===================================================================================="
echo "verify multiple device cron job task...."
sudo cat /tmp/run_mrtg.sh
echo "===================================================================================="
echo "===================================================================================="
