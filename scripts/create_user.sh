#!/bin/bash

echo -e "\033[31m[INFO]: ~~~create_user.sh starting~~~\033[0m"

#获取系统默认目录
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/~/bin
export PATH

if [ "$(whoami)" != "root" ]; then
echo -e "\033[31m当前登录用户不是root用户，请使用root用户操作。\033[0m";exit 1
fi

# 关闭服务
service iptables stop
chkconfig iptables off
chkconfig ip6tables off
setenforce 0
sed -ibak 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

USER_NAME="oracle"
GROUP_NAME1='oinstall'
GROUP_ID1=507
GROUP_NAME2='dba'
GROUP_ID2=502
GROUP_NAME3='oper'
GROUP_ID3=503
U_PASSWORD="oracle"
O_PASSWORD="oracle"
ORACLE_BASE_DIR=$1  # oracle数据库安装路径:一般为/oracle,/opt,/u01等等


# 创建组和用户Creating Required Operating System Groups and Users

testing1=$(egrep "^${USER_NAME}:" /etc/passwd)
if [ "${testing1}" != "" ]; then
    GROUP_ID=$(egrep "^${USER_NAME}:" /etc/passwd|cut -d ":" -f 4)
    GROUP_NAME=$(egrep ":${GROUP_ID}:" /etc/group|cut -d ":" -f 1)
    echo -e "\033[32m[INFO]: 用户${USER_NAME}已存在，用户组为${GROUP_NAME}。\033[0m"
else
    testing2=$(egrep "^${GROUP_NAME}:" /etc/group)
    if [ "$testing2" != "" ]; then
        useradd -g ${GROUP_NAME1} ${USER_NAME}
        echo -e "\033[32m[INFO]: 用户组${GROUP_NAME}存在，但用户${USER_NAME}不存在，已创建。\033[0m"
    else
        groupadd -g ${GROUP_ID1} ${GROUP_NAME1};
	groupadd -g ${GROUP_ID2} ${GROUP_NAME2};
	groupadd -g ${GROUP_ID3} ${GROUP_NAME3};
	useradd -g ${GROUP_NAME1} -G ${GROUP_NAME2},${GROUP_NAME3} ${USER_NAME}
	echo -e "$U_PASSWORD\n$U_PASSWORD" | passwd ${USER_NAME}
        echo -e "\033[32m[INFO]: 用户组${GROUP_NAME1}和用户${USER_NAME}都不存在，均已创建。\033[0m"
    fi
fi

# 创建目录
if test -d ${ORACLE_BASE_DIR}; then
    CURRENT_TIME=$(date +%Y%m%d%H%M%S)
    mv ${ORACLE_BASE_DIR} ${ORACLE_BASE_DIR}_${CURRENT_TIME}
    mkdir -p ${ORACLE_BASE_DIR};chown -R ${USER_NAME}:${GROUP_NAME1} ${ORACLE_BASE_DIR}
    echo -e "\033[32m[INFO]: 目录${ORACLE_BASE_DIR}已存在，自动备份为${ORACLE_BASE_DIR}_${CURRENT_TIME}，并重新创建空目录${ORACLE_BASE_DIR}。\033[0m"
else
    mkdir -p ${ORACLE_BASE_DIR}/app/oracle;chown -R ${USER_NAME}:${GROUP_NAME1} ${ORACLE_BASE_DIR}
    echo -e "\033[32m[INFO]: 目录${ORACLE_BASE_DIR}不存在，已创建。\033[0m"
fi

