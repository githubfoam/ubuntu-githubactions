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

capinfos -TmQ securitynik_kaieteur_falls.pcap >securitynik_kaieteur_falls.csv #generate a CSV style table form report
stat  securitynik_kaieteur_falls.csv

editcap -F pcapng  -c 20  securitynik_kaieteur_falls.pcap  securitynik_kaieteur_falls_split.cap

# tshark --export-objects --help
tshark -n -r securitynik_kaieteur_falls.pcap -q -z io,phs

echo "===================================================================================="
