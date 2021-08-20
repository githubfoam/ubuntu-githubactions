#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
apt-get update
apt-get install -y python3-virtualenv

# outside the sandbox
virtualenv --version
python -V
python3 -V
pip --version

# check the version of the available package in the Ubuntu repositories without installing
apt-cache policy ansible
apt-cache show ansible
apt-cache showpkg ansible

# ansible | 2.9.6+dfsg-1 | http://azure.archive.ubuntu.com/ubuntu focal/universe amd64 Packages
apt-cache madison ansible

# https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu
apt-get install -y software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt-cache madison ansible


# Create a virtualenv if one does not already exist
# python3 -m virtualenv -p $(which python3) ansible-latest 
# python3 -m virtualenv ansible-latest  
# source ansible-latest/bin/activate    # Activate the virtual environment

# inside the sandbox
# python -V
# python3 -V
# pip --version

# pip install -r requirements.txt
# pip install ansible==2.3.3.0
# ansible --version

echo "===================================================================================="
