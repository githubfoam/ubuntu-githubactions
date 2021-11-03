#!/usr/bin/env bash

set -o errexit
# set -o pipefail #Illegal option -o pipefail
set -o nounset
set -o xtrace
# set -euo pipefail

echo "===================================================================================="
# https://github.com/intel/kernel-fuzzer-for-xen-project


apt-get update -y

# Install dependencies 
apt-get install -y git build-essential libfdt-dev \
                libpixman-1-dev libssl-dev libsdl1.2-dev \
                autoconf libtool xtightvncviewer tightvncserver \
                x11vnc uuid-runtime uuid-dev bridge-utils \
                python3-dev liblzma-dev libc6-dev wget git \
                bcc bin86 gawk iproute2 libcurl4-openssl-dev \
                bzip2 libpci-dev libc6-dev libc6-dev-i386 \
                linux-libc-dev zlib1g-dev libncurses5-dev \
                patch libvncserver-dev libssl-dev libsdl-dev \
                iasl libbz2-dev e2fslibs-dev ocaml libx11-dev \
                bison flex ocaml-findlib xz-utils gettext \
                libyajl-dev libpixman-1-dev libaio-dev libfdt-dev \
                cabextract libglib2.0-dev autoconf automake \
                libtool libjson-c-dev libfuse-dev liblzma-dev \
                autoconf-archive kpartx python3-pip libsystemd-dev \
                cmake snap gcc-multilib nasm binutils bc \
                libunwind-dev


git clone https://github.com/intel/kernel-fuzzer-for-xen-project
cd kernel-fuzzer-for-xen-project
git submodule update --init

# Compile & Install Xen 

# Make sure the pci include folder exists at /usr/include/pci
# stat /usr/include/pci #stat: cannot stat '/usr/include/pci': No such file or directory
# In case it doesn't, create a symbolic link to where it's installed at
ln -s /usr/include/x86_64-linux-gnu/pci /usr/include/pci

# Before installing Xen from source make sure you don't have any pre-existing Xen packages installed
apt-get remove xen-* libxen* -y 

# compile & install Xen
cd xen
echo CONFIG_EXPERT=y > xen/.config
echo CONFIG_MEM_SHARING=y >> xen/.config
./configure --disable-pvshim --enable-githttp --enable-ovmf
make -C xen olddefconfig
make -j4 dist-xen
make -j4 dist-tools
# su - ##similar to the case when you explicitly log in as root user from the log-in screen
make -j4 install-xen
make -j4 install-tools
echo "/usr/local/lib" > /etc/ld.so.conf.d/xen.conf
ldconfig
echo "none /proc/xen xenfs defaults,nofail 0 0" >> /etc/fstab
systemctl enable xen-qemu-dom0-disk-backend.service
systemctl enable xen-init-dom0.service
systemctl enable xenconsoled.service
echo "GRUB_CMDLINE_XEN_DEFAULT=\"hap_1gb=false hap_2mb=false dom0_mem=6096M hpet=legacy-replacement iommu=no-sharept\"" >> /etc/default/grub
update-grub
# reboot

# Case study: Xen Project Hypervisor (Section IX)
# https://github.com/spectector/spectector-benchmarks

echo "===================================================================================="
