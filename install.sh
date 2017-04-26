#!/bin/sh

source config/oracle.conf
sh scripts/set_language.sh
sh scripts/install_rpm.sh
sh scripts/add_ipaddr.sh

echo $ORACLE_BASE_DIR
echo $ORACLE_SID
echo $ZIP_PACKAGE_PATH
# create_user.sh has one parameter: ORACLE_BASE_DIR=/oracle
sh scripts/create_user.sh $ORACLE_BASE_DIR

# start to alter the config
sh scripts/alter_sysctl.sh
sh scripts/alter_limits.sh
sh scripts/alter_login.sh
sh scripts/alter_profile.sh
# create_user.sh has two parameter: ORACLE_BASE_DIR=/oracle and ORACLE_SID
sh scripts/alter_bash_profile.sh $ORACLE_BASE_DIR $ORACLE_SID

# alter parameters in install_oracle.rsp
# INVENTORY_LOCATION=/oracle/app/oraInventory
# ORACLE_BASE=/oracle/app/oracle
# ORACLE_HOME=/oracle/app/oracle/product/11.2.0/db_1
# alter parameters in install_oracle.rsp:ORACLE_HOSTNAME
sed -i '/INVENTORY_LOCATION/d' rsp/install_oracle.rsp
sed -i '/ORACLE_BASE/d' rsp/install_oracle.rsp
sed -i '/ORACLE_HOME/d' rsp/install_oracle.rsp
sed -i '/ORACLE_HOSTNAME/d' rsp/install_oracle.rsp
echo "INVENTORY_LOCATION=$ORACLE_BASE_DIR/app/oraInventory" >> rsp/install_oracle.rsp
echo "ORACLE_BASE=$ORACLE_BASE_DIR/app/oracle" >> rsp/install_oracle.rsp
echo "ORACLE_HOME=$ORACLE_BASE_DIR/app/oracle/product/11.2.0/db_1" >> rsp/install_oracle.rsp
echo "ORACLE_HOSTNAME=$(hostname)" >> rsp/install_oracle.rsp

# scripts/install_oracle.sh  # ZIP_PACKAGE_PATH:oracle package path 
sh scripts/install_oracle.sh $ZIP_PACKAGE_PATH $(pwd)/rsp

# scripts/install_netca.sh   # transfer rsp path
sh scripts/install_netca.sh $(pwd)/rsp

# 处理dbca.rsp文件
sed -i '/GDBNAME/d' rsp/dbca.rsp
sed -i '/SID/d' rsp/dbca.rsp
echo -e "GDBNAME = \"$ORACLE_SID\"" >> rsp/dbca.rsp
echo -e "SID = \"$ORACLE_SID\"" >> rsp/dbca.rsp


# scripts/install_dbca.sh   # transfer rsp path
sh scripts/install_dbca.sh $(pwd)/rsp


# scripts/autostart_oracle.sh
sh scripts/autostart_oracle.sh $ORACLE_BASE_DIR
