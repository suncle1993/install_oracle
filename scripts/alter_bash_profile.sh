#!/bin/bash
echo -e "\033[31m[INFO]: ~~~alter_bash_profile.sh starting~~~\033[0m"

cp /home/oracle/.bash_profile /home/oracle/.bash_profile_bak
sed -i "/#oracle_bash_profile_begin/,/#oracle_bash_profile_end/d" /home/oracle/.bash_profile

cat >> /home/oracle/.bash_profile << "EOF"
#oracle_bash_profile_begin
EOF

echo "ORACLE_SID=${2}" >> /home/oracle/.bash_profile
echo "ORACLE_BASE=${1}/app/oracle" >> /home/oracle/.bash_profile

cat >> /home/oracle/.bash_profile << "EOF"
ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
export ORACLE_BASE ORACLE_HOME ORACLE_SID
PATH=$ORACLE_HOME/bin:$PATH
export PATH
#oracle_bash_profile_end
EOF
source /home/oracle/.bash_profile
echo -e "\033[32m[INFO]: /home/oracle/.bash_profile is ok!\033[0m"
