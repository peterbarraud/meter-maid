ECHO off

SET phpport=8089
SET startdir=backoffice
SET phpdir=%startdir%\php.min

ECHO Running PHP on PORT %phpport%

%phpdir%\php -S localhost:%phpport% -t %startdir% -c %phpdir%\php.ini || (
	pause
)
