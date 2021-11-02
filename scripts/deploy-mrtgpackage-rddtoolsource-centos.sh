#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="

yum update -y
yum install wget -y

# install Apache
yum install httpd -y
systemctl enable --now httpd #enable and start
# systemctl restart httpd
echo "httpd status ...$(systemctl is-active httpd)"

# Install mrtg snmp packages
yum install net-snmp mrtg net-snmp-utils -y

# rddtool source compile build install
# yum groupinstall "Development tools" -y
yum install gcc gd gd-devel perl libpng libxml2-devel cairo-devel glib2-devel pango-devel perl-devel perl-CGI net-snmp net-snmp-utils -y 

echo "========================================================================================================="
echo "=====================rrdtool install==============================================================="

cd /tmp && wget --no-check-certificate http://oss.oetiker.ch/rrdtool/pub/rrdtool.tar.gz 
tar zfx rrdtool.tar.gz && cd rrdtool-*
./configure --prefix=/usr/local/rrdtool
echo "=====================configure finished==============================================================="
sleep 3
make
echo "=====================make finished==============================================================="
sleep 3
make install
echo "=====================make install finished==============================================================="


mv /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.orig


cat | sudo tee /etc/snmp/snmpd.conf << EOF
rocommunity public
syslocation "location of your DC"
syscontact your contact mail
EOF
cat /etc/snmp/snmpd.conf #verify

systemctl enable --now snmpd

echo "snmpd status ...$(systemctl is-active snmpd)"

snmpwalk -v2c -c public localhost system

mkdir -p /var/www/html/mymrtg

mv /etc/mrtg/mrtg.cfg /etc/mrtg/mrtg.cfg.orig 

sh -c '/usr/bin/cfgmaker --global "WorkDir: /var/www/html/mymrtg" --global "Options[_]: growright, bits" --global "RunAsDaemon: No" --global "LogFormat: rrdtool" --global "PathAdd: /usr/local/rrdtool/bin" --global "LibAdd: /usr/local/rrdtool/lib/perl/5.26.3" -ifref=ip --output /etc/mrtg/mrtg.cfg public@localhost'
cat /etc/mrtg/mrtg.cfg | head -10 #verify

#test
# env LANG=C /usr/bin/mrtg /etc/mrtg/mrtg.cfg 
# sudo mkdir -p /var/lock/mrtg
# sudo mkdir -p /var/lib/mrtg
env LANG=C /usr/bin/mrtg /etc/mrtg/mrtg.cfg --logging /var/log/mrtg.log --lock-file /var/lock/mrtg/mrtg_l --confcache-file /var/lib/mrtg/mrtg.ok


# Create a cron job for MRTG to generate data at every 5 mins
cat | sudo tee /etc/cron.d/cron-mrtg << EOF
*/5 * * * * root LANG=C LC_ALL=C /usr/bin/mrtg /etc/mrtg/mrtg.cfg --logging /var/log/mrtg.log --lock-file /var/lock/mrtg/mrtg_l --confcache-file /var/lib/mrtg/mrtg.ok
EOF
#verify
cat /etc/cron.d/cron-mrtg
chkconfig crond on #Add the cron daemon to the server start-up

sh -c 'indexmaker --columns=1 /etc/mrtg/mrtg.cfg > /var/www/html/mymrtg/index.html'

mv /etc/httpd/conf.d/mrtg.conf /etc/httpd/conf.d/mrtg.conf.orig

cat | sudo tee /etc/httpd/conf.d/mrtg.conf << EOF
Alias /mrtg /var/www/html/mymrtg
<Location /mrtg>
    Require local
    # Require ip 10.1.2.3
    # Require host example.org
</Location>
EOF
cat /etc/httpd/conf.d/mrtg.conf #verify


chkconfig httpd on #dd the httpd service to the server start-up
systemctl restart httpd
echo "httpd status ...$(systemctl is-active httpd)"

#MANUAL FILE COPY
#/usr/local/mrtg2/lib/mrtg2/ # MRTG SOURCE INSTALL 
# use lib qw(/usr/lib64/mrtg2); # MRTG PACKAGE INSTALL
#  /var/www/cgi-bin/14all.cgi
 # #use lib qw(/usr/local/mrtg-2/lib/mrtg2);
# use lib qw(/usr/lib64/mrtg2);
# comment
# #use lib qw(/usr/local/rrdtool-1.0.38/lib/perl);
# $cfgfile = '/etc/mrtg/mrtg.cfg';
# $cfgfiledir = '/etc/mrtg'
# $cfgfile = 'mrtg.cfg';
# # chmod 505 /var/www/cgi-bin/14all.cgi

# copied via vagrant file provisioner
stat /tmp/14all.cgi.package 
mv /tmp/14all.cgi.package /var/www/cgi-bin/14all.cgi
chmod 505 /var/www/cgi-bin/14all.cgi
stat /var/www/cgi-bin/14all.cgi



# # # browse
# # # http://<server_ip>/mrtg
curl -I http://localhost/mymrtg/



# echo "===================================================================================="

