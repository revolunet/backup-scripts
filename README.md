Backup scripts
======

simple backup scripts.


 - mysql.sh : Linux MySQL tgz compressed backups

     - first setup a MySQL backup readonly password in an empty `MYSQL_PWD` file
     - execute the `create-backupuser.sh` script to create the user in your MySQL
     - add `mysql.sh` to your CRON to schedule MySQL backups. add a path argument if you want to backup in some special place
     - the whole MySQL databases and tables will be backed-up and gzipped in separated files

 - mysql.bat : Windows MysQL 7zip compressed backups

     - config variable in mysql.bat
     - create a scheduled task to run this file daily
     - the whole MySQL databases will be backed-up and 7zipped in a single dump file

 - Todo 
 
     -  random password generation
     -  backup stats + error alerts

