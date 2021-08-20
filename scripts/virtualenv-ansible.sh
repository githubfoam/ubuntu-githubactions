#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
apt-get update
apt-get install -y python3-virtualenv

virtualenv --version
python -V
python3 -V
pip --version

# Create a virtualenv if one does not already exist
python3 -m virtualenv -p $(which python3) ansible-latest 
# python3 -m virtualenv ansible-latest  
source ansible-latest/bin/activate    # Activate the virtual environment

pip install -r requirements.txt
# pip install ansible
ansible --version

echo "===================================================================================="
