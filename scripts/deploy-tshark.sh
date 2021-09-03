#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail
echo "===================================================================================="
echo "============================install tshart========================================================"
sudo apt-get update 
sudo apt-get install -y tshark

git clone https://github.com/SecurityNik/SUWtHEh-.git
cd "SUWtHEh-"
echo "===================================================================================="
echo "============================pcap fingerpointing========================================================"
capinfos securitynik_kaieteur_falls.pcap  #generate a long form report

capinfos -T securitynik_kaieteur_falls.pcap #generate a TAB delimited table form report

capinfos -TmQ securitynik_kaieteur_falls.pcap >securitynik_kaieteur_falls.csv #generate a CSV style table form report
stat  securitynik_kaieteur_falls.csv

editcap -F pcapng  -c 20  securitynik_kaieteur_falls.pcap  securitynik_kaieteur_falls_split.pcap

capinfos securitynik_kaieteur_falls_split.pcap #generate a long form report

echo "===================================================================================="
echo "============================tshart analysis========================================================"

# Exporting suspicious/malicious content
tshark -n -r securitynik_kaieteur_falls.pcap -q -z io,phs

# Export suspicious content  from HTTP
tshark -n -r securitynik_kaieteur_falls.pcap -T fields -e http.request.method -e http.host -e http.request.uri | sort | uniq

pwd 
ls -lai 
# tshark --export-objects http,/dir/ -q
# tshark -n -r securitynik_kaieteur_falls.pcap --export-objects http,/dir/
# ls -lai
# file kaieteur_falls.jpeg
# stat kaieteur_falls.jpeg

echo "===================================================================================="
echo "===================================================================================="
