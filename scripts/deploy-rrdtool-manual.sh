#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
sudo apt-get update -y

sudo apt-get install -y librrds-perl rrdtool

# https://oss.oetiker.ch/rrdtool/download.en.html
# https://github.com/oetiker/rrdtool-1.x

### Global Config Options

# HtmlDir: /var/www/html/mrtg
# ImageDir: /var/www/html/img
# LogDir: /var/log/mrtg
# Logformat: rrdtool
# PathAdd: /usr/bin #rddtool binary
# #LibAdd: /usr/local/rrdtool-1.0.46/lib/perl
# LibAdd: /usr/lib/x86_64-linux-gnu/perl5

# Options[_]: growright, bits

# WorkDir: /var/www/html/mrtg

#building from source
# sudo apt-get install -y build-essential
# sudo apt-get install libpango1.0-dev libxml2-dev
# sudo wget --no-check-certificate https://oss.oetiker.ch/rrdtool/pub/rrdtool-1.7.2.tar.gz
# sudo tar -zxf rrdtool-1.7.2.tar.gz
# cd rrdtool-1.7.2
# # sudo ./configure && sudo make && sudo make install
# sudo ./configure --disable-tcl --disable-python --disable-ruby && sudo make && sudo make install
# cd bindings/perl-shared
# sudo make clean
# perl Makefile.PL
# sudo make && sudo make install
