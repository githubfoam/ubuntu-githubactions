#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
echo "===================================================================================="

# https://www.howtoforge.com/tutorial/how-to-install-and-configure-mrtg-on-ubuntu-1804/
apt-get update

# install Apache
apt-get install -y apache2

systemctl restart apache2
systemctl is-active apache2

# Install snmp packages
apt-get install -y snmpd snmp 

# monitoring localhost
#adjust line number before proceeding
sed -i -e '70i\' -e 'rocommunity  public localhost' /etc/snmp/snmpd.conf 
#verify
cat /etc/snmp/snmpd.conf | grep "localhost"

systemctl restart snmpd
systemctl is-active snmpd

# # create a home where web pages related to the program can reside
mkdir -p /var/www/mrtg

# # Install mrtg packages
# # apt-get install mrtg -y
# #manual auto approval NOT WORKING
# yes | apt-get install mrtg -y 



# # Backup the original /etc/mrt.cfg file
# cp /etc/mrtg.cfg /etc/mrtg.cfg.ORIGINAL

# # Create a configuration file for MRTG
# # cfgmaker <snmp_community_string>@<ip_address_of_device_to_be_monitored> > /etc/mrtg.cfg
#OPTION 1
# sudo sh -c 'cfgmaker public@localhost > /etc/mrtg.cfg'
#OPTION 2
# sudo cfgmaker --output=/etc/mrtg.cfg public@localhost



# #verify
# cat /etc/mrtg.cfg| grep "/var/www/mrtg"



# # Create and index file for the webserver 
# # indexmaker /etc/mrtg.cfg > /var/www/mrtg/index.html
# sh -c 'indexmaker /etc/mrtg.cfg > /var/www/mrtg/index.html'

# sudo /usr/bin/indexmaker --output=/var/www/mrtg/index.html --title="Monitor localhost" --sort=name --enumerate \
# /etc/mrtg.cfg \
# /etc/mrtg/mem.cfg \
# /etc/mrtg/disk_hrStorageTable.cfg \
# /etc/mrtg/disk_dskTable.cfg \
# /etc/mrtg/user_idle_cpu.cfg \
# /etc/mrtg/user_sys_cpu.cfg \
# /etc/mrtg/active_cpu.cfg

# #verify
# ls -lai /var/www/mrtg/

#apache virtual host
#  sudo vi /etc/apache2/apache2.conf

# Alias /mrtg "/var/www/mrtg/"
# <Directory "/var/www/mrtg/">
#     Options None
#     AllowOverride None
#     Require all granted
# </Directory>

# service apache2 restart

# sudo env LANG=C /usr/bin/mrtg /etc/mrtg.cfg

# $ sudo cat /tmp/run_mrtg.sh
# sudo env LANG=C /usr/bin/mrtg /etc/mrtg.cfg --logging /var/log/mrtg/mrtg.log
# sudo env LANG=C /usr/bin/mrtg /etc/mrtg/mem.cfg --logging /var/log/mrtg/mem.log
# sudo env LANG=C /usr/bin/mrtg /etc/mrtg/disk_hrStorageTable.cfg --logging /var/log/mrtg/disk_hrStorageTable.cfg.log
# sudo env LANG=C /usr/bin/mrtg /etc/mrtg/disk_dskTable.cfg --logging /var/log/mrtg/disk_dskTable.log
# sudo env LANG=C /usr/bin/mrtg /etc/mrtg/user_idle_cpu.cfg --logging /var/log/mrtg/user_idle_cpu.log
# sudo env LANG=C /usr/bin/mrtg /etc/mrtg/user_sys_cpu.cfg --logging /var/log/mrtg/user_sys_cpu.log
# sudo env LANG=C /usr/bin/mrtg /etc/mrtg/active_cpu.cfg --logging /var/log/mrtg/active_cpu.log


#CRON JOB
# $ cat /etc/cron.d/mrtg-nagios
# */5 * * * *  root  sh /tmp/run_mrtg.sh >> /var/log/run_mrtg_cron.log 2>&1

# cat | sudo tee /etc/cron.d/cron-mrtg << EOF
# */5 * * * * env LANG=C /usr/bin/mrtg /etc/mrtg.cfg
# EOF
# #verify
# cat /etc/cron.d/cron-mrtg


# # browse
# # http://<server_ip>/mrtg
# curl http://localhost/mrtg/



echo "===================================================================================="
echo "===================================================================================="