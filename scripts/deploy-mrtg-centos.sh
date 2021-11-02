#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
# https://www.techtransit.org/mrtg-installation-on-centos-7-rhel-7-fedora-and-linux/


# install Apache
# yum update -y
yum install httpd -y
systemctl enable --now httpd
# systemctl is-active httpd #verify

# Install mrtg snmp packages
yum install net-snmp mrtg net-snmp-utils -y

mv /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.orig

cat | sudo tee /etc/snmp/snmpd.conf << EOF
rocommunity public
syslocation "location of your DC"
syscontact your contact mail
EOF
cat /etc/snmp/snmpd.conf #verify

systemctl enable --now snmpd

snmpwalk -v2c -c public localhost system

mkdir -p /var/www/html/mymrtg

# sh -c 'cfgmaker --snmp-options=:::::2 --ifref=descr --ifdesc=descr --global "WorkDir: /var/www/html/mymrtg" public@localhost > /etc/mrtg/mrtg.cfg'

# mv /etc/httpd/conf.d/mrtg.conf /etc/httpd/conf.d/mrtg.conf.orig

# cat | sudo tee /etc/httpd/conf.d/mrtg.conf << EOF
# Alias /mrtg /var/www/html/mymrtg
# <Location /mrtg>
#     Require local
#     # Require ip 10.1.2.3
#     # Require host example.org
# </Location>
# EOF
# cat /etc/httpd/conf.d/mrtg.conf #verify

# sh -c 'indexmaker --columns=1 /etc/mrtg/mrtg.cfg > /var/www/html/mymrtg/index.html'
# systemctl restart httpd

# #test
# sudo sh -c 'for (( i=1 ; i <= 3 ; i++ )); do env LANG=C mrtg /etc/mrtg/mrtg.cfg; done'
# # cron it
# cat | sudo tee /etc/cron.d/cron-mrtg << EOF
# */5 * * * * root LANG=C LC_ALL=C /usr/bin/mrtg /etc/mrtg/mrtg.cfg --lock-file /var/lock/mrtg/mrtg_l --confcache-file /var/lib/mrtg/mrtg.ok
# EOF
# #verify
# cat /etc/cron.d/cron-mrtg
# # crontab -l 

# # # browse
# # # http://<server_ip>/mrtg
# curl -I http://localhost/mymrtg/



echo "===================================================================================="
