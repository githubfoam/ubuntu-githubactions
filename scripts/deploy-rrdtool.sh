#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
apt-get update -y

apt-get install -y librrds-perl rrdtool


mkdir -p /var/www/html/img

# https://oss.oetiker.ch/rrdtool/download.en.html
# https://github.com/oetiker/rrdtool-1.x
