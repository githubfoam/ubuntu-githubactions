sudo env LANG=C /usr/bin/mrtg /etc/mrtg.cfg --logging /var/log/mrtg/mrtg.log
sudo env LANG=C /usr/bin/mrtg /etc/mrtg/mem.cfg --logging /var/log/mrtg/mem.log
sudo env LANG=C /usr/bin/mrtg /etc/mrtg/disk_hrStorageTable.cfg --logging /var/log/mrtg/disk_hrStorageTable.cfg.log
sudo env LANG=C /usr/bin/mrtg /etc/mrtg/disk_dskTable.cfg --logging /var/log/mrtg/disk_dskTable.log
sudo env LANG=C /usr/bin/mrtg /etc/mrtg/user_idle_cpu.cfg --logging /var/log/mrtg/user_idle_cpu.log
sudo env LANG=C /usr/bin/mrtg /etc/mrtg/user_sys_cpu.cfg --logging /var/log/mrtg/user_sys_cpu.log
sudo env LANG=C /usr/bin/mrtg /etc/mrtg/active_cpu.cfg --logging /var/log/mrtg/active_cpu.log
