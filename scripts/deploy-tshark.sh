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

editcap -F pcapng  -c 20  securitynik_kaieteur_falls.pcap  /tmp/securitynik_kaieteur_falls_split.pcap
ls -lai /tmp/
# securitynik_kaieteur_falls_split_00000_20190120175303.pcap
# securitynik_kaieteur_falls_split_0000X_XXXXXXXXXXXXXX.pcap
# capinfos securitynik_kaieteur_falls_split_0000X_XXXXXXXXXXXXXX.pcap #generate a long form report

echo "===================================================================================="
echo "============================tshart analysis========================================================"

# Exporting suspicious/malicious content
tshark -n -r securitynik_kaieteur_falls.pcap -q -z io,phs

echo "============================tshart analysis http========================================================"

# Export suspicious content  from HTTP
tshark -n -r securitynik_kaieteur_falls.pcap -T fields -e http.request.method -e http.host -e http.request.uri | sort | uniq


# timeout 10s sudo tshark --export-objects http,/tmp/ -q
# tshark -n -r securitynik_kaieteur0_falls.pcap --export-objects http,/tmp/
# ls -lai
# file kaieteur_falls.jpeg
# stat kaieteur_falls.jpeg
# clamscan kaieteur_falls.jpeg
echo "============================tshart analysis smb========================================================"

# Export suspicious content  from SMB
tshark -n -r smb-export.pcap -q -T fields -e smb2.filename | sort | uniq

tshark -n -r smb-export.pcap -Y 'smb2.filename contains pdf'

tshark -n -r smb-export.pcap -Y 'frame.number == 189'

tshark -n -r smb-export.pcap -Y 'frame.number == 189' -T fields -e smb2.tree 

tshark -n -r smb-export.pcap -Y 'frame.number == 189' -T fields -e smb2.tree -e smb2.filename -e smb2.acct -e smb2.domain -e smb2.host

# tshark -n -r smb-export.pcap -Y 'frame.number == 189' -T fields \ 
# -e smb2.tree \
# -e smb2.filename \
# -e smb2.acct \
# -e smb2.domain \
# -e smb2.host

tshark -n -r smb-export.pcap -Y 'frame.number == 189' -Y 
# tshark -n -r smb-export.pcap -Y 'frame.number == 189' -Y | more

tshark -n -r decode-as-ssh.pcap

sudo apt-get install -yq p7zip-full
7z e decode-as.7z
ls -lai 
tshark -n -r decode-as.pcap

echo "===================================================================================="
echo "===================================================================================="
