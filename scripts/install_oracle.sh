#!/bin/bash
echo -e "\033[31m[INFO]: ~~~install_oracle.sh starting~~~\033[0m"

ZIP_PACKAGE_PATH=$1
RSP_PATH=$2
echo $RSP_PATH
chown -R oracle:oinstall $ZIP_PACKAGE_PATH/linux.x64_11gR2_database_1of2.zip
chown -R oracle:oinstall $ZIP_PACKAGE_PATH/linux.x64_11gR2_database_2of2.zip
xhost +
#su - oracle <<EOF
#unzip $ZIP_PACKAGE_PATH/linux.x64_11gR2_database_1of2.zip -d $ZIP_PACKAGE_PATH
#unzip $ZIP_PACKAGE_PATH/linux.x64_11gR2_database_2of2.zip -d $ZIP_PACKAGE_PATH
#cd $ZIP_PACKAGE_PATH/database
#./runInstaller -silent -ignoreSysPrereqs -force -ignorePrereq -responseFile $RSP_PATH/install_oracle.rsp

#exit;
#EOF
su oracle -c "cd ${ZIP_PACKAGE_PATH}/database; ./runInstaller -silent -waitForCompletion -responseFile ${RSP_PATH}/db_install.rsp"
