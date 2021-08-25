#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
# https://help.ubuntu.com/community/MRTG
sudo apt-get update
# install Apache
apt-get install -y apache2

# Install snmp packages
apt-get install -y snmpd

# Install mrtg packages
apt-get install -y mrtg

# create a home where web pages related to the program can reside
sudo mkdir /var/www/mrtg

# Backup the original /etc/mrt.cfg file
cp /etc/mrtg.cfg /etc/mrtg.cfg.ORIGINAL

# Create a configuration file for MRTG
# cfgmaker <snmp_community_string>@<ip_address_of_device_to_be_monitored> > /etc/mrtg.cfg

# Create and index file for the webserver 
# indexmaker /etc/mrtg.cfg > /var/www/mrtg/index.html

# browse
# http://<server_ip>/mrtg
echo "===================================================================================="
