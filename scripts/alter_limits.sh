#!/bin/bash
echo -e "\033[31m[INFO]: ~~~alter_limits.sh starting~~~\033[0m"

cp /etc/security/limits.conf /etc/security/limits.conf_bak
sed -i "/#oracle_limits_begin/,/#oracle_limits_end/d" /etc/security/limits.conf
cat >> /etc/security/limits.conf << "EOF"
#oracle_limits_begin
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
#oracle_limits_end
EOF
echo -e "\033[32m[INFO]: /etc/security/limits.conf is ok!\033[0m"
