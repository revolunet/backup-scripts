#!/bin/sh

#
# this simple script backup any local MySQL db to ./backups or directory given as 1st arg
# uses the user name `backup` and password stored in MYSQL_PWD file
# Dbs and tables are saved separately
# just call this via a cron script
#


MYDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OUTDIR="$MYDIR/backups";

if [ -n "$1" ]
then
	OUTDIR=$1;
fi

cd $MYDIR

if [ ! -e MYSQL_PWD ]
then
	echo "ERROR: Please create a 'MYSQL_PWD' file with MySQL backup user password!";
	exit
fi

DATE=$(date +%Y%m%d%H%M);
OUTDIR="$OUTDIR/$DATE";

MYSQL_USER=backup;
MYSQL_PWD=`cat MYSQL_PWD`;

echo "BACKUP to $OUTDIR";
mkdir -p $OUTDIR >& /dev/null;
 
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"

DBS="$($MYSQL -h 127.0.0.1 -u$MYSQL_USER -p$MYSQL_PWD -Bse 'show databases')"
for DATABASE in $DBS
do
	TABLES="$($MYSQL -h 127.0.0.1 -u$MYSQL_USER -p$MYSQL_PWD $DATABASE -Bse 'show TABLES')"
	for TABLE in $TABLES
	do
		FILENAME="$OUTDIR/$DATABASE__$TABLE"__$DATE.sql;
		$MYSQLDUMP -h 127.0.0.1 -u $MYSQL_USER -p$MYSQL_PWD $DATABASE "$TABLE" > "$FILENAME";
		if [ -e "$FILENAME" ]
		then
			tar -czvf $FILENAME.tgz $FILENAME >& /dev/null;
			rm $FILENAME;
		fi
	done;
done;


