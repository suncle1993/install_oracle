#!/bin/bash
echo -e "\033[31m[INFO]: ~~~autostart_oracle.sh starting~~~\033[0m"

ORACLE_BASE_DIR=$1
sed -i 's/db_1:N/db_1:Y/' /etc/oratab 
sed -i 's/ORACLE_HOME_LISTNER=$1/ORACLE_HOME_LISTNER=$ORACLE_HOME/' $ORACLE_BASE_DIR/app/oracle/product/11.2.0/db_1/bin/dbstart
sed -i 's/ORACLE_HOME_LISTNER=$1/ORACLE_HOME_LISTNER=$ORACLE_HOME/' $ORACLE_BASE_DIR/app/oracle/product/11.2.0/db_1/bin/dbshut

sed -i "/#oracle_autostart_begin/,/#oracle_autostart_end/d" /etc/rc.local

cat >> /etc/rc.local << "EOF"
#oracle_autostart_begin
EOF
echo "su - oracle -c \"$ORACLE_BASE_DIR/app/oracle/product/11.2.0/db_1/bin/dbstart\"" >> /etc/rc.local
echo "su - oracle -c \"$ORACLE_BASE_DIR/app/oracle/product/11.2.0/db_1/bin/emctl start dbconsole\"" >> /etc/rc.local
cat >> /etc/rc.local << "EOF"
#oracle_autostart_end
EOF
