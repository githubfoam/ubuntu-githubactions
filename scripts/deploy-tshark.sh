#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "============================install tshart========================================================"
sudo apt-get update 
sudo apt-get install -y tshark

git clone https://github.com/SecurityNik/SUWtHEh-.git
cd "SUWtHEh-"

echo "============================pcap fingerpointing========================================================"
capinfos securitynik_kaieteur_falls.pcap  #generate a long form report

capinfos -T securitynik_kaieteur_falls.pcap #generate a TAB delimited table form report

capinfos -TmQ securitynik_kaieteur_falls.pcap >securitynik_kaieteur_falls.csv #generate a CSV style table form report
stat  securitynik_kaieteur_falls.csv

editcap -F pcapng  -c 20  securitynik_kaieteur_falls.pcap  securitynik_kaieteur_falls_split.cap

echo "============================tshart analysis========================================================"

# tshark --export-objects --help
# Exporting suspicious/malicious content
tshark -n -r securitynik_kaieteur_falls.pcap -q -z io,phs

# Export suspicious content  from HTTP
tshark -n -r securitynik_kaieteur_falls.pcap -T fields -e http.request.method -e http.host -e http.request.uri | sort | uniq


echo "===================================================================================="
