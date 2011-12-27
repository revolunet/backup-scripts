#!/bin/sh

MYDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $MYDIR;

if [ ! -e MYSQL_PWD ]
then
	echo "ERROR: Please create a 'MYSQL_PWD' file with MySQL backup user password!";
	exit
fi


# creates the backup USER
sed -e "s/{{PASSWORD}}/$(cat MYSQL_PWD)/g" < create-backupuser.sql | mysql -u root -p

echo "MySQL backup user password created";

