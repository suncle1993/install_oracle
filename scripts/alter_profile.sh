#!/bin/bash
echo -e "\033[31m[INFO]: ~~~alter_profile.sh starting~~~\033[0m"

cp /etc/profile /etc/profile_bak
sed -i "/#oracle_profile_begin/,/#oracle_profile_end/d" /etc/profile

cat >> /etc/profile << "EOF"
#oracle_profile_begin
if [ $USER = "oracle" ]; then         
    if [ $SHELL = "/bin/ksh" ]; then              
      ulimit -p 16384              
      ulimit -n 65536          
    else              
      ulimit -u 16384 -n 65536             
    fi
fi
#oracle_profile_end
EOF
echo -e "\033[32m[INFO]: /etc/profile is ok!\033[0m"
