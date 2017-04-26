#!/bin/bash

echo -e "\033[31m[INFO]: ~~~alter_sysctl.sh starting~~~\033[0m"
shmmax=$(free | grep 'Mem' | awk '{print $2/2+100000}')

cp /etc/sysctl.conf /etc/sysctl.conf_bak
sed -i '/fs.aio-max-nr/d' /etc/sysctl.conf
sed -i '/fs.file-max/d' /etc/sysctl.conf
sed -i '/kernel.shmmax/d' /etc/sysctl.conf
sed -i '/kernel.shmall/d' /etc/sysctl.conf
sed -i '/kernel.shmmni/d' /etc/sysctl.conf
sed -i '/kernel.sem/d' /etc/sysctl.conf
sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
sed -i '/net.core.rmem_default/d' /etc/sysctl.conf
sed -i '/net.core.rmem_max/d' /etc/sysctl.conf
sed -i '/net.core.wmem_default/d' /etc/sysctl.conf
sed -i '/net.core.wmem_max/d' /etc/sysctl.conf

sed -i "/#oracle_sysctl_begin/,/#oracle_sysctl_end/d" /etc/sysctl.conf

cat >> /etc/sysctl.conf << "EOF"
#oracle_sysctl_begin
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
EOF
echo "kernel.shmmax = ${shmmax}000" >> /etc/sysctl.conf
cat >> /etc/sysctl.conf << "EOF"
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default=262144
net.core.rmem_max=4194304
net.core.wmem_default=262144
net.core.wmem_max=1048586
#oracle_sysctl_end
EOF
/sbin/sysctl -p

echo -e "\033[32m[INFO]: /etc/sysctl.conf is ok!\033[0m"
