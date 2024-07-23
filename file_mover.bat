:: Batch to automate moving certain files from one dir to other. 
:: Files are moved to the as per the name & extension.
:: Directory name where files will be moved ,  will be the current date at destination path. 
:: Moved address files will have date appended at the end. 
:: logger file will be created at destination.  
:: move function is used, can be replaced with xcopy.   
:: Replace file names & extensions as per your requirement

@echo off
setlocal enabledelayedexpansion

:: Get the current date in format - DD-MM-YYYY
for /f "tokens=2 delims==" %%i in ('"wmic os get localdatetime /value"') do set datetime=%%i
set date=!datetime:~6,2!-!datetime:~4,2!-!datetime:~0,4!


:: declare the source path and destiantion directory
set sourceDir=D:\devops\file mover\source
set DestiantionDir=E:\devops\file mover\destination
:: decalre logger file name 
set logFile=%DestiantionDir%\mover_op_logs.txt
echo ------------------------------------------------------------------------------------------------------------ >> "%logFile%"
echo Date: %DATE% Time: %TIME% >> "%logFile%"

:: Create the target directory with the current date
set targetDir=%DestiantionDir%\%date%
if not exist "%targetDir%" (
    mkdir "%targetDir%"
	
    echo %DATE% %TIME% Created directory %targetDir% >> "%logFile%" 
) else (
    echo %DATE% %TIME% Directory %targetDir% already exists >> "%logFile%" 
)

:: Move files from source path to target directory | change filename , extension as per requirement. 
for %%f in ("%sourceDir%\test*.csv" "%sourceDir%\test*.txt") do (
    ::xcopy "%%f" "%targetDir%\"
	move "%%f" "%targetDir%\"
    echo %DATE% %TIME% Moved %%f to %targetDir% >> "%logFile%" 
)

:: TO move files appending current date to each filename | change filename , extension as per requirement. 
for %%f in ("%sourceDir%\name*.csv" "%sourceDir%\name2*.csv" "%sourceDir%\name*.csv") do (
    :: Get the file name and extension
    set "filename=%%~nf"
    set "extension=%%~xf"
    
    :: Move the file with the date appended to its name
	::xcopy "%%f" "%targetDir%\!filename!_!date!!extension!" /Y
	move "%%f" "%targetDir%\!filename!_!date!!extension!"
    echo %DATE% %TIME% Moved %%f to %targetDir%\!filename!_!date!!extension! >> "%logFile%" 
)


echo %DATE% %TIME% All files have been moved to %DestiantionDir% >> "%logFile%" 
endlocal



