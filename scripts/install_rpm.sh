#!/bin/sh
echo -e "\033[31m[INFO]: ~~~install_rpm.sh starting~~~\033[0m"

#yum安装依赖包
yum -y install gcc*
yum -y install binutils compat-db control-center glibc libXp libstdc++ libstdc++-devel make openmotif sysstat libaio libaio-devel libgcc libstdc++ libstdc++-devel unixODBC unixODBC-devel ksh 
#安装桌面：需要先判断桌面服务是否存在
yum -y groupinstall "X Window System"
yum -y groupinstall "Desktop"
#startx
