#!/bin/bash
echo -e "\033[31m[INFO]: ~~~add_ipaddr.sh starting~~~\033[0m"

# 获取系统IP并加入hosts
IPADDR=`ifconfig |grep -v 127.0.0.1 |grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}'`
HOSTNAME=`hostname`
testingip=$(egrep "^${IPADDR}" /etc/hosts)
if [ "${testingip}" != "" ]; then
	echo -e "\033[32m[INFO]: 该${IPADDR}已存在hosts文件中。\033[0m"
else
	echo ${IPADDR} ${HOSTNAME} >> /etc/hosts
    echo -e "\033[32m[INFO]: ${IPADDR}加入hosts文件成功。\033[0m"
fi
