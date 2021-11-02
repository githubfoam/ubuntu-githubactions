#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="

# # install Apache
yum update -y
yum install httpd -y
systemctl enable --now httpd #enable and start
# systemctl restart httpd #hanging
# systemctl is-active httpd #verify
echo "httpd status ...$(systemctl is-active httpd)"

# rddtool source compile build install
# yum groupinstall "Development tools" -y
yum install gcc gd gd-devel perl libpng libxml2-devel cairo-devel glib2-devel pango-devel perl-devel perl-CGI net-snmp net-snmp-utils -y 

mv /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.orig

cat | sudo tee /etc/snmp/snmpd.conf << EOF
rocommunity public
syslocation "location of your DC"
syscontact your contact mail
EOF
cat /etc/snmp/snmpd.conf #verify

systemctl enable --now snmpd
# systemctl restart snmpd
echo "snmpd status ...$(systemctl is-active snmpd)"

snmpwalk -v2c -c public localhost system

yum install wget -y #centos stream 8

echo "========================================================================================================="
echo "=====================mrtg install==============================================================="
cd /tmp && wget --no-check-certificate http://oss.oetiker.ch/mrtg/pub/mrtg.tar.gz
tar zfx mrtg.tar.gz && cd mrtg-*
sh -c './configure --prefix=/usr/local/mrtg2'
sleep 7
echo "=====================configure finished==============================================================="
make
sleep 7
echo "=====================make finished==============================================================="
make install
sleep 7
echo "=====================make install finished==============================================================="


echo "========================================================================================================="
echo "=====================rrdtool install==============================================================="

cd /tmp && wget --no-check-certificate http://oss.oetiker.ch/rrdtool/pub/rrdtool.tar.gz 
tar zfx rrdtool.tar.gz && cd rrdtool-*
sh -c './configure --prefix=/usr/local/rrdtool'
sleep 7
echo "=====================configure finished==============================================================="
make
sleep 7
echo "=====================make finished==============================================================="
make install
sleep 7
echo "=====================make install finished==============================================================="




mkdir -p /var/www/html/mymrtg

mkdir -p /etc/mrtg

sh -c '/usr/local/mrtg2/bin/cfgmaker --global "WorkDir: /var/www/html/mymrtg" --global "Options[_]: growright, bits" --global "RunAsDaemon: No" --global "LogFormat: rrdtool" --global "PathAdd: /usr/local/rrdtool/bin" --global "LibAdd: /usr/local/rrdtool/lib/perl/5.26.3" -ifref=ip --output /etc/mrtg/mrtg.cfg public@localhost'
cat /etc/mrtg/mrtg.cfg | head -10 #verify

# #test
# env LANG=C /usr/local/mrtg2/bin/mrtg /etc/mrtg/mrtg.cfg
env LANG=C /usr/local/mrtg2/bin/mrtg /etc/mrtg/mrtg.cfg --logging /var/log/mrtg.log 


cat | sudo tee /etc/cron.d/cron-mrtg << EOF
*/5 * * * * root LANG=C LC_ALL=C /usr/local/mrtg2/bin/mrtg /etc/mrtg/mrtg.cfg --logging /var/log/mrtg.log
EOF
cat /etc/cron.d/cron-mrtg #verify
chkconfig crond on #Add the cron daemon to the server start-up

sh -c '/usr/local/mrtg2/bin/indexmaker --output=/var/www/html/mymrtg/index.html /etc/mrtg/mrtg.cfg'
 


cat | sudo tee /etc/httpd/conf.d/mrtg.conf << EOF
Alias /mrtg /var/www/html/mymrtg
<Location /mrtg>
    Require local
    # Require ip 10.1.2.3
    # Require host example.org
</Location>
EOF
cat /etc/httpd/conf.d/mrtg.conf #verify


# # #MANUAL FILE COPY
# #/usr/local/mrtg2/lib/mrtg2/ # MRTG SOURCE INSTALL 
# # use lib qw(/usr/lib64/mrtg2); # MRTG PACKAGE INSTALL

# # #  /var/www/cgi-bin/14all.cgi
# ;
# # # comment
# # # #use lib qw(/usr/local/rrdtool-1.0.38/lib/perl);
# # # $cfgfile = '/etc/mrtg/mrtg.cfg';
# # # $cfgfiledir = '/etc/mrtg'
# # # $cfgfile = 'mrtg.cfg';


# copied via vagrant file provisioner
stat /tmp/14all.cgi.source 
mv /tmp/14all.cgi.source /var/www/cgi-bin/14all.cgi
chmod 505 /var/www/cgi-bin/14all.cgi
stat /var/www/cgi-bin/14all.cgi




# chkconfig httpd on #add the httpd service to the server start-up
# systemctl restart httpd
# echo "httpd status ...$(systemctl is-active httpd)"

# # # # # browse
# # # # # http://<server_ip>/mrtg
curl -I http://localhost/mymrtg/



echo "===================================================================================="

