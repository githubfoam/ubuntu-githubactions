#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
apt-get install -y python-virtualenv

python -m virtualenv ansible-latest  # Create a virtualenv if one does not already exist
source ansible/bin/ansible-latest   # Activate the virtual environment

python -m pip install ansible
ansible --version

echo "===================================================================================="
