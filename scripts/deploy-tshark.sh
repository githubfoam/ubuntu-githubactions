#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
sudo apt-get update 
sudo apt-get install -y tshark

git clone https://github.com/SecurityNik/SUWtHEh-.git
cd "SUWtHEh-"

capinfos securitynik_kaieteur_falls.pcap  #generate a long form report
capinfos -T securitynik_kaieteur_falls.pcap #generate a TAB delimited table form report

echo "===================================================================================="
