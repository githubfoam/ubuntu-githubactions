#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
# https://assets.nagios.com/downloads/ncpa/docs/Installing-NCPA.pdf
sudo apt-get update
wget https://assets.nagios.com/downloads/ncpa/ncpa-latest.amd64.deb

sudo dpkg -i ./ncpa-latest.amd64.deb

sudo systemctl restart ncpa_listener.service

echo "===================================================================================="
