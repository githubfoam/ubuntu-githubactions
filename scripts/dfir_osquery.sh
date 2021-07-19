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
echo "Finding new processes listening on network ports.Finding backdoors"
echo "malware listens on port to provide command and control (C&C) or direct shell access,query periodically and diffing with the last known good "
echo "===================================================================================="
osqueryi --json 'SELECT DISTINCT process.name, listening.port, listening.address, process.pid FROM processes AS process JOIN listening_ports AS listening ON process.pid = listening.pid;' > new_processes_listening_network_ports.json
cat new_processes_listening_network_ports.json

echo "===================================================================================="
echo "Finding suspicious outbound network activity; any processes that do not fit within whitelisted network behavior"
echo "e.g. a process scp’ing traffic externally when it should only perform HTTP(s) connections outbound"
echo "===================================================================================="
osqueryi --json 'select s.pid, p.name, local_address, remote_address, family, protocol, local_port, remote_port from process_open_sockets s join processes p on s.pid = p.pid where remote_port not in (80, 443) and family = 2;' > suspicious_outbound_network_activity.json
cat suspicious_outbound_network_activity.json

echo "===================================================================================="
echo "any process whose original binary has been deleted or modified"
echo "attackers leave a malicious process running but delete the original binary on disk"
echo "===================================================================================="
osqueryi --json 'SELECT name, path, pid FROM processes WHERE on_disk = 0;' > original_binary_deleted.json
cat original_binary_deleted.json

echo "===================================================================================="
echo "Finding new kernel modules which was loaded"
echo "===================================================================================="
osqueryi --json 'select name from kernel_modules;' > kernel_modules.json
cat kernel_modules.json

echo "===================================================================================="
echo "view a list of loaded kernel modules"
echo "===================================================================================="
osqueryi --json 'select name, used_by, status from kernel_modules where status="Live";' > loaded_kernel_modules.json
cat loaded_kernel_modules.json

echo "===================================================================================="
echo "Finding malware that have been scheduled to run at specific intervals"
echo "===================================================================================="
osqueryi --json 'select command, path from crontab ;' > malware_crontab.json
cat malware_crontab.json

echo "===================================================================================="
echo "Finding backdoored binaries"
echo "===================================================================================="
osqueryi --json 'select * from suid_bin ;' > backdoored_binaries.json
cat backdoored_binaries.json

echo "===================================================================================="
echo "all recent file activity on the server"
echo "===================================================================================="
osqueryi --json 'select target_path, action, uid from file_events;' > recent_file_activity.json
cat recent_file_activity.json