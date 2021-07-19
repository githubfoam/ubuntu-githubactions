#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
echo "get systeminfo"
echo "===================================================================================="
osqueryi --json 'select cpu_type, cpu_brand, hardware_vendor, hardware_model from system_info;' > system_info.json
cat system_info.json

echo "===================================================================================="
echo "Finding new processes listening on network ports"
echo "malware listens on port to provide command and control (C&C) or direct shell access,query periodically and diffing with the last known good "
echo "===================================================================================="
osqueryi --json 'SELECT DISTINCT process.name, listening.port, listening.address, process.pid FROM processes AS process JOIN listening_ports AS listening ON process.pid = listening.pid;' > new_processes_listening_network_ports.json
cat new_processes_listening_network_ports.json