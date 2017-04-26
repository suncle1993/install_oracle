# install_oracle

前提是必须安装好yum源

## 基础环境

1. set_language.sh：设置语言为中文，无参
2. install_rpm.sh：安装依赖包，无参，需要先配置好yum源
3. add_ipaddr.sh：/etc/hosts中加入IPADDR，无参
4. create_user.sh：创建oracle用户和组，参数：ORACLE_BASE_DIR=/oracle
5. alter_sysctl.sh：修改sysctl参数，无参
6. alter_limits.sh：修改limits参数，无参
7. alter_login.sh：修改login参数，需要传入系统位数（64,32）
8. alter_profile.sh：修改文件打开数目限制，无参
9. alter_bash_profile.sh：修改环境变量，参数：ORACLE_BASE_DIR=/oracle，ORACLE_SID=ltjsdb75

## 安装数据库软件，建监听，建库

**install_oracle.sh**

安装oracle软件，需要传入响应文件install_oracle.rsp所在目录的绝对路径

根据ORACLE_BASE_DIR=/oracle参数修改install_oracle.rsp中以下三个参数

```
INVENTORY_LOCATION=/oracle/app/oraInventory
ORACLE_BASE=/oracle/app/oracle
ORACLE_HOME=/oracle/app/oracle/product/11.2.0/db_1
```

根据hostname命令设置install_oracle.rsp中ORACLE_HOSTNAME

```
ORACLE_HOSTNAME=host-10-199-129-74
```

需要传入linux.x64_11gR2_database_1of2.zip两个包所在的路径，修改代码

**install_netca.sh**

netca静默建监听，需要传入响应文件netca.rsp所在目录的绝对路径

**install_dbca.sh**

dbca静默建库，需要传入响应文件dbca.rsp所在目录的绝对路径

## 整体安装

由于以上各个部分都写成了单独的shell脚本，因此可以自由组合，也可以自由选用。可将组合内容写入install.sh目录中

**oracle安装包需要放在/tmp目录下**





