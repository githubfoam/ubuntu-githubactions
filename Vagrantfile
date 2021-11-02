

Vagrant.configure(2) do |config|
  config.vm.box_check_update = false

  # vbox template for all vagrant instances
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "512"
    vb.cpus = 2
  end

             config.vm.define "vg-mrtg-01" do |k8scluster|
                # k8scluster.vm.box = "bento/ubuntu-21.04"
                k8scluster.vm.box = "bento/centos-8.3"
                k8scluster.vm.hostname = "vg-mrtg-01"
                k8scluster.vm.network "private_network", ip: "192.168.10.16"
                #Disabling the default /vagrant share can be done as follows:
                k8scluster.vm.synced_folder ".", "/vagrant", disabled: true
                k8scluster.vm.provider "virtualbox" do |vb|
                    vb.name = "vbox-mrtg-01"
                    vb.memory = "512"
                end
                k8scluster.vm.provision :shell, path: "scripts/bootstrap.sh"
                k8scluster.vm.provision :shell, path: "scripts/deploy-mrtg-centos.sh"
                # k8scluster.vm.provision :shell, path: "scripts/deploy-rrdtool.sh"
              end

              config.vm.define "vg-mrtg-02" do |k8scluster|
                # k8scluster.vm.box = "bento/ubuntu-20.04"
                k8scluster.vm.box = "centos/stream8"
                # k8scluster.vm.box = "bento/centos-8.3" #OK
                k8scluster.vm.hostname = "vg-mrtg-02"
                k8scluster.vm.network "private_network", ip: "192.168.10.17"
                #Disabling the default /vagrant share can be done as follows:
                k8scluster.vm.synced_folder ".", "/vagrant", disabled: true
                k8scluster.vm.provider "virtualbox" do |vb|
                    vb.name = "vbox-mrtg-02"
                    vb.memory = "512"
                end
                k8scluster.vm.provision "file", source: "mrtg/rddtool-cgi/14all.cgi.package", destination: "/tmp/14all.cgi.package"                                
                # k8scluster.vm.provision :shell, path: "scripts/deploy-mrtgpackage-rddtoolsource-centos.sh"
                k8scluster.vm.provision :shell, path: "scripts/bootstrap.sh"
                # k8scluster.vm.provision :shell, path: "scripts/deploy-rrdtool.sh"
              end              

              #MRTG Source RddTool Source
              config.vm.define "vg-mrtg-03" do |k8scluster|
                # k8scluster.vm.box = "bento/ubuntu-21.04"
                # k8scluster.vm.box = "centos/stream8" #NOT OK
                k8scluster.vm.box = "bento/centos-8.3" #OK
                k8scluster.vm.hostname = "vg-mrtg-03"
                k8scluster.vm.network "private_network", ip: "192.168.10.18"
                #Disabling the default /vagrant share can be done as follows:
                k8scluster.vm.synced_folder ".", "/vagrant", disabled: true
                k8scluster.vm.provider "virtualbox" do |vb|
                    vb.name = "vbox-mrtg-03"
                    vb.memory = "512"
                end
                            
               
                # k8scluster.vm.provision "file", source: "mrtg\rddtool-cgi\14all.cgi", destination: "/usr/local/mrtg2/lib/mrtg2"
                # WINDOWS PATH CONVERTED LINUX PATH, file copy from windows host to linux guest
                k8scluster.vm.provision "file", source: "mrtg/rddtool-cgi/14all.cgi.source", destination: "/tmp/14all.cgi.source"                                
                k8scluster.vm.provision :shell, path: "scripts/deploy-mrtgsource-rddtoolsource-centos.sh"
                k8scluster.vm.provision :shell, path: "scripts/bootstrap.sh"
                # k8scluster.vm.provision :shell, path: "scripts/deploy-mrtg-v1.sh"
                # # k8scluster.vm.provision :shell, path: "scripts/deploy-rrdtool.sh"
                # k8scluster.vm.provision :shell, path: "scripts/file_copy_init.sh"
                # k8scluster.vm.provision "file", source: "/tmp/github/ubuntu-githubactions/mrtg/cfgs", destination: "/etc/mrtg"
                # k8scluster.vm.provision "file", source: "/tmp/github/ubuntu-githubactions/mrtg/cron/mrtg-nagios", destination: "/etc/cron.d/cron-mrtg"
                # k8scluster.vm.provision "file", source: "/tmp/github/ubuntu-githubactions/mrtg/cron/run_mrtg.sh", destination: "/tmp/run_mrtg.sh"
                # k8scluster.vm.provision "file", source: "/tmp/github/ubuntu-githubactions/mrtg/cron/mrtg-nagios", destination: "/etc/cron.d/mrtg-nagios"
                # k8scluster.vm.provision "file", source: "/tmp/github/ubuntu-githubactions/mrtg/snmp/snmpd.conf", destination: "/etc/snmp/snmpd.conf"
                # k8scluster.vm.provision "file", source: "/tmp/github/ubuntu-githubactions/mrtg/apache2/apache2.conf", destination: "/etc/apache2/apache2.conf"
                # k8scluster.vm.provision :shell, path: "scripts/file_copy_close.sh"
              end  

              config.vm.define "vg-mrtg-04" do |k8scluster|
                # k8scluster.vm.box = "bento/ubuntu-21.04"
                k8scluster.vm.box = "centos/stream8"
                k8scluster.vm.hostname = "vg-mrtg-04"
                k8scluster.vm.network "private_network", ip: "192.168.10.19"
                #Disabling the default /vagrant share can be done as follows:
                k8scluster.vm.synced_folder ".", "/vagrant", disabled: true
                k8scluster.vm.provider "virtualbox" do |vb|
                    vb.name = "vbox-mrtg-04"
                    vb.memory = "512"
                end
                k8scluster.vm.provision :shell, path: "scripts/bootstrap.sh"
                # k8scluster.vm.provision :shell, path: "scripts/deploy-mrtg.sh"
                # k8scluster.vm.provision :shell, path: "scripts/deploy-rrdtool.sh"
              end  
end
