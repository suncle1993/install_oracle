#!/bin/bash
echo -e "\033[31m[INFO]: ~~~alter_login.sh starting~~~\033[0m"

cp /etc/pam.d/login /etc/pam.d/login_bak
sed -i "/#oracle_login_begin/,/#oracle_login_end/d" /etc/pam.d/login
cat >> /etc/pam.d/login << "EOF"
#oracle_login_begin
session required /lib64/security/pam_limits.so  #for 64
session required pam_limits.so
#oracle_login_end
EOF
echo -e "\033[32m[INFO]: /etc/pam.d/login is ok!\033[0m"
