#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
# https://owasp.org/www-community/Fuzzing
# https://gitlab.com/akihe/radamsa

apt-get update -y
apt-get install gcc make git wget -y

git clone https://gitlab.com/akihe/radamsa.git && cd radamsa && make && sudo make install

echo "HAL 9000" | radamsa

echo "===================================================================================="
