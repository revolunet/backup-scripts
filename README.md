Backup scripts
======

simple backup scripts.


 - MySQL

     - first setup a MysQL backup readonly password in an empty MYSQL_PWD file
     - launch the create-backupuser.sh script to create the user in your MySQL
     - add mysql.sh to your CRON to schedule MySQL backups
     - the whole MySQL databases and tables will be backedup and gzipped in separated files

