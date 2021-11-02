#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
# https://github.com/IntelLabs/kAFL


apt-get update -y


git clone https://github.com/IntelLabs/kAFL.git ~/kafl


cd ~/kafl
./install.sh deps     # check platform and install dependencies
sh -c 'install.sh perms'    # allow current user to control KVM (/dev/kvm)
# $ ./install.sh qemu     # download, patch and build Qemu
# $ ./install.sh linux    # download, patch and build Linux

echo "===================================================================================="
