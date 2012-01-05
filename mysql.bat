@Echo OFF
TITLE mySQL Databases backup


@REM Variables pour le DUMP
SET host=localhost
SET port=3306
SET user_backup=MYSQL_USER
SET pass_backup=MYSQL_PASSWORD

SET BACKUP_DIR="g:\saves"

SET MYSQLDUMP="C:\Program Files\MySQL\MySQL Server 4.1\bin\mysqldump"
SET ZIP7="C:\Program Files\7-Zip\7zg.exe"


@REM dont touch below


SET Y=%date:~6,4%
SET M=%date:~0,2%
SET D=%date:~3,2%
SET H=%time:~-11,2%
SET I=%time:~-8,2%
SET S=%time:~-5,2%
SET DATE_FILE=%Y%%M%%D%
 

SET temp_dump=%BACKUP_DIR%"\%host%_%DATE_FILE%.sql"
SET comp_dump=%BACKUP_DIR%"\%host%_%DATE_FILE%.7z"
 
IF EXIST %temp_dump% (
    del %temp_dump%
)
IF EXIST %comp_dump% (
    del %comp_dump%
)

ECHO %temp_dump%

@REM Execution du dump
@call %MYSQLDUMP% --single-transaction -h %host% -P %port% -u %user_backup% -p%pass_backup% --add-drop-table --add-locks --extended-insert --quote-names --compress --all-databases > %temp_dump%

@REM Compression du DUMP
@call %ZIP7% a -t7z -mx7 -r %comp_dump% %temp_dump%

@REM Suppression du dump temporaire
@del %temp_dump%