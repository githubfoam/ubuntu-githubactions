#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
# https://help.ubuntu.com/community/MRTG
apt-get update

# install Apache
apt-get install -y apache2

# Install snmp packages
apt-get install -y snmpd snmp 

#adjust line number before proceeding
sed -i -e '70i\' -e 'rocommunity  public localhost' /etc/snmp/snmpd.conf 
#verify
cat /etc/snmp/snmpd.conf | grep "localhost"

systemctl restart snmpd
systemctl is-active snmpd

# # Install mrtg packages
# # sudo apt-get install -y mrtg
# #manual auto approval NOT WORKING
# yes | apt-get install -y mrtg 

# # create a home where web pages related to the program can reside
mkdir -p /var/www/html/mrtg


# # Create a configuration file for MRTG
# # cfgmaker <snmp_community_string>@<ip_address_of_device_to_be_monitored> > /etc/mrtg.cfg
# sudo sh -c 'cfgmaker public@localhost > /etc/mrtg.cfg'

# # Backup the original /etc/mrt.cfg file
# cp /etc/mrtg.cfg /etc/mrtg.cfg.ORIGINAL

# sudo sed -i.bck 's/^WorkDir: \/var\/www\/mrtg/WorkDir: \/var\/www\/html\/mrtg/' /etc/mrtg.cfg
# #verify
# cat /etc/mrtg.cfg| grep "/var/www/html/mrtg"


# #RRDTOOL
# # sudo sh -c 'cfgmaker public@localhost --global 'LogFormat: rrdtool' --global "workdir:/var/mrtg"  --global 'IconDir:/mrtg' > /etc/mrtg.cfg'
# # sudo sh -c 'cfgmaker public@localhost --global 'LogFormat: rrdtool' --global "workdir:/var/www/html/mrtg"  --global 'IconDir:/var/www/html/img' > /etc/mrtg.cfg'

# # Create and index file for the webserver 
# # indexmaker /etc/mrtg.cfg > /var/www/mrtg/index.html
# sh -c 'indexmaker /etc/mrtg.cfg > /var/www/html/mrtg/index.html'
# #verify
# ls -lai /var/www/html/mrtg/

cat | sudo tee /etc/cron.d/cron-mrtg << EOF
*/5 * * * * env LANG=C /usr/bin/mrtg /etc/mrtg.cfg
EOF
#verify
cat /etc/cron.d/cron-mrtg
crontab -l 

# # browse
# # http://<server_ip>/mrtg
# curl http://localhost/mrtg/



echo "===================================================================================="
echo "================================rddtool integration===================================================="

# sudo mkdir /etc/mrtgconf

# sudo mkdir /etc/mrtgconf/mrtgorrd # rrd configs

# # sudo mkdir /var/www/mrtg
# sudo mkdir /var/www/html/mrtg/Cisco-MRTG
# sudo mkdir /var/www/html/mrtg/mrtgorrd/Cisco-MRTG_rrd
# sudo mkdir /var/www/html/rrd

#  cfgmaker –snmp-options=::::2 –show-op-down –zero-speed=1000000000 –global “Options[_]:growright,bits” –global “WorkDir:/var/www/html/mrtg/omurga_adiniz/” backbone_community@backboneIP >/etc/mrtgconf/mrtg.omurga_adiniz
 
echo "===================================================================================="
