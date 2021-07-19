#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

osqueryi --json 'select cpu_type, cpu_brand, hardware_vendor, hardware_model from system_info;' > system_info.json
cat system_info.json