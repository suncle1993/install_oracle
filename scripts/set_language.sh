#!/bin/bash
echo -e "\033[31m[INFO]: ~~~set_language.sh starting~~~\033[0m"

cp /etc/sysconfig/i18n /etc/sysconfig/i18n_bak
echo -e "\033[32m[INFO]: file /etc/sysconfig/i18n has been backuped!\033[0m"
echo 'LANG="en_US.UTF-8"' > /etc/sysconfig/i18n
source /etc/sysconfig/i18n
echo -e "\033[32m[INFO]: /etc/sysconfig/i18n has been in force!\033[0m"
