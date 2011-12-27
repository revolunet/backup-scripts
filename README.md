Backup scripts
======

simple backup scripts.


 - MySQL

     - first setup a MysQL backup readonly password in an empty `MYSQL_PWD` file
     - execute the `create-backupuser.sh` script to create the user in your MySQL
     - add `mysql.sh` to your CRON to schedule MySQL backups. add a path argument if you want to backup in some special place
     - the whole MySQL databases and tables will be backed-up and gzipped in separated files

 - Todo 
 
     -  random password generation
     -  backup stats + error alerts