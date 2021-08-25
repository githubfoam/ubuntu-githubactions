#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="

# http://spritelink.github.io/NIPAP/docs/install-debian.html
# Anything after PostgreSQL 9.0 
apt-get update 
apt-get install -y postgresql-9.1-ip4r postgresql-contrib-9.1

# Add the NIPAP repo to your package sources, add our public key for proper authentication of our packages and update your lists -y
echo "deb http://spritelink.github.io/NIPAP/repos/apt stable main extra" | sudo tee /etc/apt/sources.list.d/nipap.list
wget -O - https://spritelink.github.io/NIPAP/nipap.gpg.key | sudo apt-key add -
sudo apt-get update -y

#  install the backend
sudo apt-get install -y nipapd

# Web UI
sudo apt-get install -y nipap-www
echo "===================================================================================="
