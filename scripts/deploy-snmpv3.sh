#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
apt-get update 
apt-get -y install snmp snmpd libsnmp-dev

service snmpd status
service snmpd stop

# Add SNMP v3 user
#     Change AuthPassword to your Authentication password
#     Change CryptoPassword to your Crypto Password
#     Change privUser to your private users username
sudo net-snmp-config --create-snmpv3-user -ro -A AuthPassword -X CryptoPassword -a MD5 -x AES privUser


cat /etc/snmp/snmpd.conf

echo "===================================================================================="
