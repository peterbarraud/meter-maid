set dbname=%1
.\backoffice\mariadb.min\bin\mysqldump -u root -p %dbname% > .\backoffice\services\%dbname%.sql