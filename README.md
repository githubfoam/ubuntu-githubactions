# ubuntu-githubactions
[![ubuntu 18.04  osquery CI workflow](https://github.com/githubfoam/ubuntu-githubactions/actions/workflows/1804-osquery-wf.yml/badge.svg)](https://github.com/githubfoam/ubuntu-githubactions/actions/workflows/1804-osquery-wf.yml)  
[![ubuntu 20.04 osquery CI workflow](https://github.com/githubfoam/ubuntu-githubactions/actions/workflows/2004-osquery-wf.yml/badge.svg)](https://github.com/githubfoam/ubuntu-githubactions/actions/workflows/2004-osquery-wf.yml)  
[![ubuntu latest osquery CI workflow](https://github.com/githubfoam/ubuntu-githubactions/actions/workflows/latest-osquery-wf.yml/badge.svg)](https://github.com/githubfoam/ubuntu-githubactions/actions/workflows/latest-osquery-wf.yml)  
~~~~

osquery> select * from yara ;
Error: no query solution
osquery> select time, severity, message from syslog ;
W1115 22:01:25.011281 19521 virtual_table.cpp:930] Table syslog_events is event-based but events are disabled
W1115 22:01:25.011309 19521 virtual_table.cpp:937] Please see the table documentation: https://osquery.io/schema/#syslog_events
~~~~
Debian osquery
~~~~
osqueryd --help
osqueryi --verbose

osqueryi
W1129 09:58:36.125007 19325 options.cpp:91] Cannot set unknown or invalid flag: log_result_events
W1129 09:58:36.125895 19325 options.cpp:91] Cannot set unknown or invalid flag: enable_monitor
Using a virtual database. Need help, type '.help'
osquery>

osquery> .show

view mode of query results
osquery> .mode csv
osquery> .mode list
osquery> .mode column
osquery> .mode line

list all available tables
osquery> .tables

query table "file_events" if exists
osquery> .schema file_events

osquery> .schema users
CREATE TABLE users(`uid` BIGINT, `gid` BIGINT, `uid_signed` BIGINT, `gid_signed` BIGINT, `username` TEXT, `description` TEXT, `directory` TEXT, `shell` TEXT, `uuid` TEXT, `type` TEXT HIDDEN, `is_hidden` INTEGER HIDDEN, PRIMARY KEY (`uid`, `username`)) WITHOUT ROWID;

osquery> .schema processes
CREATE TABLE processes(`pid` BIGINT, `name` TEXT, `path` TEXT, `cmdline` TEXT, `state` TEXT, `cwd` TEXT, `root` TEXT, `uid` BIGINT, `gid` BIGINT, `euid` BIGINT, `egid` BIGINT, `suid` BIGINT, `sgid` BIGINT, `on_disk` INTEGER, `wired_size` BIGINT, `resident_size` BIGINT, `total_size` BIGINT, `user_time` BIGINT, `system_time` BIGINT, `disk_bytes_read` BIGINT, `disk_bytes_written` BIGINT, `start_time` BIGINT, `parent` BIGINT, `pgroup` BIGINT, `threads` INTEGER, `nice` INTEGER, `is_elevated_token` INTEGER HIDDEN, `elapsed_time` BIGINT HIDDEN, `handle_count` BIGINT HIDDEN, `percent_processor_time` BIGINT HIDDEN, `upid` BIGINT HIDDEN, `uppid` BIGINT HIDDEN, `cpu_type` INTEGER HIDDEN, `cpu_subtype` INTEGER HIDDEN, `phys_footprint` BIGINT HIDDEN, PRIMARY KEY (`pid`)) WITHOUT ROWID;
osquery>


show details about the system hardware
osquery> SELECT * FROM system_info;
hostname,uuid,cpu_type,cpu_subtype,cpu_brand,cpu_physical_cores,cpu_logical_cores,cpu_microcode,physical_memory,hardware_vendor,hardware_model,hardware_version,hardware_serial,computer_name,local_hostname
vg-osquery-01,26dbc95e-9186-4fdd-a315-5181c84e2673,x86_64,158,Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz,2,2,,502169600,,,,,vg-osquery-01,vg-osquery-01

osquery> SELECT * FROM os_version;
name,version,major,minor,patch,build,platform,platform_like,codename
Ubuntu,19.04 (Disco Dingo),19,4,0,,ubuntu,debian,disco

osquery> SELECT * FROM kernel_info;
version,arguments,path,device
5.0.0-17-generic,ro net.ifnames=0 biosdevname=0 quiet,/boot/vmlinuz-5.0.0-17-generic,/dev/mapper/vagrant--vg-root

osquery> SELECT * FROM kernel_modules LIMIT 5;
name,size,used_by,status,address
vboxsf,81920,-,Live,0x0000000000000000
dm_multipath,32768,-,Live,0x0000000000000000
scsi_dh_rdac,16384,-,Live,0x0000000000000000
scsi_dh_emc,16384,-,Live,0x0000000000000000
scsi_dh_alua,20480,-,Live,0x0000000000000000



Checking Repository and Packages

osquery> SELECT * FROM apt_sources;
name,source,base_uri,release,version,maintainer,components,architectures
security.ubuntu.com/ubuntu disco-security universe,/etc/apt/sources.list,http://security.ubuntu.com/ubuntu,disco,19.04,Ubuntu,main restricted universe multiverse,amd64 arm64 armhf i386 ppc64el s390x
security.ubuntu.com/ubuntu disco-security multiverse,/etc/apt/sources.list,http://security.ubuntu.com/ubuntu,disco,19.04,Ubuntu,main restricted universe multiverse,amd64 arm64 armhf i386 ppc64el s390x
ppa.launchpad.net/ansible/ansible/ubuntu disco main,/etc/apt/sources.list.d/ansible-ubuntu-ansible-disco.list,http://ppa.launchpad.net/ansible/ansible/ubuntu,disco,19.04,LP-PPA-ansible-ansible,main,amd64 arm64 armhf i386 ppc64el s390x
osquery-packages.s3.amazonaws.com/xenial xenial main,/etc/apt/sources.list.d/osquery_packages_s3_amazonaws_com_xenial.list,https://osquery-packages.s3.amazonaws.com/xenial,xenial,,osquery-builder,main,amd64

osquery> SELECT name, base_uri, release, maintainer, components FROM apt_sources ORDER BY name;
name,base_uri,release,maintainer,components
osquery-packages.s3.amazonaws.com/xenial xenial main,https://osquery-packages.s3.amazonaws.com/xenial,xenial,osquery-builder,main
ppa.launchpad.net/ansible/ansible/ubuntu disco main,http://ppa.launchpad.net/ansible/ansible/ubuntu,disco,LP-PPA-ansible-ansible,main
security.ubuntu.com/ubuntu disco-security multiverse,http://security.ubuntu.com/ubuntu,disco,Ubuntu,main restricted universe multiverse
security.ubuntu.com/ubuntu disco-security universe,http://security.ubuntu.com/ubuntu,disco,Ubuntu,main restricted universe multiverse

osquery> SELECT * FROM deb_packages;
osquery> SELECT name, version FROM deb_packages ORDER BY name;
osquery> SELECT name, version FROM deb_packages WHERE name="unzip";
name,version
unzip,6.0-22ubuntu1

List the users
osquery> SELECT * FROM users;

who else other than you is logged into the system now
osquery> select * from logged_in_users ;

previous logins
osquery> select * from last ;

If there’s no output, then it means the IPTables firewall has not been configured.
osquery> select * from iptables ;
osquery> select chain, policy, src_ip, dst_ip from iptables ;

Get The Process Name, Port, and PID for All Processes
osquery> SELECT DISTINCT processes.name, listening_ports.port, processes.pid FROM listening_ports JOIN processes USING (pid);

top 10 most active processes count, name
osquery> select count(pid) as total, name from processes group by name order by total desc limit 10;

top 10 largest processes by resident memory size
osquery> select pid, name, uid, resident_size from processes order by resident_size desc limit 10;

osquery> SELECT address FROM etc_hosts WHERE hostnames = 'localhost';
+-----------+
| address   |
+-----------+
| 127.0.0.1 |
+-----------+
osquery> SELECT * FROM arp_cache;
+----------+-------------------+-----------+-----------+
| address  | mac               | interface | permanent |
+----------+-------------------+-----------+-----------+
| 10.0.2.2 | 52:54:00:12:35:02 | eth0      | 0         |
| 10.0.2.3 | 52:54:00:12:35:03 | eth0      | 0         |
+----------+-------------------+-----------+-----------+

~~~~
CTI, DFIR, Debian
~~~~
Finding new processes listening on network ports; malware listens on port to provide command and control (C&C) or direct shell access,query periodically and diffing with the last ‘known good’
osquery> SELECT DISTINCT process.name, listening.port, listening.address, process.pid FROM processes AS process JOIN listening_ports AS listening ON process.pid = listening.pid;

Finding suspicious outbound network activity; any processes that do not fit within whitelisted network behavior, e.g. a process scp’ing traffic externally when it should only perform HTTP(s) connections outbound
osquery> select s.pid, p.name, local_address, remote_address, family, protocol, local_port, remote_port from process_open_sockets s join processes p on s.pid = p.pid where remote_port not in (80, 443) and family = 2;

Finding processes that are running whose binary has been deleted from the disk;any process whose original binary has been deleted or modified;attackers leave a malicious process running but delete the original binary on disk.
osquery> SELECT name, path, pid FROM processes WHERE on_disk = 0;

Finding new kernel modules which was loaded; query periodically and diffing against older results,kernel modules can be checked against a whitelist/blacklist , rootkits
osquery> select name from kernel_modules;

view a list of loaded kernel modules; query periodically and compare its output against older results to see if anything’s changed
osquery> select name, used_by, status from kernel_modules where status="Live";

Finding malware that have been scheduled to run at specific intervals
osquery> select command, path from crontab ;

Finding backdoored binaries; files on the system that are setuid-enabled, any that are not supposed to be on the system, query periodically and compare its results against older results so that you can keep an eye on any additions.
osquery> select * from suid_bin ;

Finding backdoors; query that lists all the listening ports, output includes those ports that the server should be listening on
osquery> select * from listening_ports ;

all recent file activity on the server
osquery> select target_path, action, uid from file_events ;



~~~~

Centos osquery
~~~~
list of all installed RPM packages
osquery> .all rpm_packages;
~~~~

~~~~
predefined tables
<https://osquery.io/schema/4.1.1>

# https://osquery.readthedocs.io/en/stable/installation/install-linux/

https://github.com/google/santa
https://github.com/groob/moroz
https://github.com/zentralopensource/zentral

https://github.com/actions/virtual-environments

~~~~

