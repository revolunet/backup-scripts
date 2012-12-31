#!/bin/sh
NOW=$(date +"%d-%m-%Y")
MUSER="$2"
MPASS="$3"
MHOST="$1"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"
 
DBS="$($MYSQL -u $MUSER -h $MHOST -p$MPASS -Bse 'show databases')"
for db in $DBS
do
 FILE=mysql-$db.$NOW-$(date +"%T").gz
 echo "creating $FILE"
 $MYSQLDUMP -u $MUSER -h $MHOST -p$MPASS $db | $GZIP -9 > $FILE
done
