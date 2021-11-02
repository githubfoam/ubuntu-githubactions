#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "============================deploying radamsa========================================================"
# https://owasp.org/www-community/Fuzzing
# https://gitlab.com/akihe/radamsa

apt-get update -y
apt-get install gcc make git wget -y

git clone https://gitlab.com/akihe/radamsa.git && cd radamsa && make && sudo make install

echo "HAL 9000" | radamsa

echo "==========================Fuzzing with Radamsa=========================================================="
#radamsa can be used to fuzz data going through a pipe
echo "aaa" | radamsa 

#add one 'a' to the input
echo "aaa" | radamsa

# By default radamsa will grab a random seed from /dev/urandom if it is not given a specific random state to start from
#The random state to use can be given with the -s parameter, which is followed by a number. 
#Using the same random state will result in the same data being generated.
echo "Fuzztron 2000" | radamsa --seed 4

#radamsa happens to choose to use a number mutator which replaces textual numbers with something else.
#generate more than one output by using the -n parameter
echo "1 + (2 + (3 + 4))" | radamsa --seed 12 -n 4

#test programs that read input from standard input
echo "100 * (1 + (2 / 3))" | radamsa -n 10000 | bc

echo "===================================================================================="
