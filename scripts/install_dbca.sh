#!/bin/sh
RSP_PATH=$1
su - oracle <<EOF
dbca  -silent  -createDatabase -responseFile $RSP_PATH/dbca.rsp
exit;
EOF
