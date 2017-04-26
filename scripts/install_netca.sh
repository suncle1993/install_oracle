#!/bin/sh
echo -e "\033[31m[INFO]: ~~~install_netca.sh starting~~~\033[0m"

RSP_PATH=$1
su - oracle <<EOF
netca /silent /responseFile $RSP_PATH/netca.rsp
exit;
EOF
