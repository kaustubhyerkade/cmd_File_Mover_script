# cmd_File_Mover_script
Batch to automate moving certain files from one dir to other with addon features like logger &amp; append date etc.


:: Batch to automate moving certain files from one dir to other. 
:: Files are moved to the as per the name & extension.
:: Directory name where files will be moved ,  will be the current date at destination path. 
:: Moved address files will have date appended at the end. 
:: logger file will be created at destination which logs all operations to a log file, .  
:: move function is used, can be replaced with xcopy.   
:: Replace file names & extensions as per your requirement


This script will create a new directory named with the current date, copy all files from the specified source directory 
into this new directory while appending the date to each file's name, and log each operation with a timestamp to mover_op_logs.txt in the target parent directory.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
set logFile=%targetParentDir%\operation_log.txt                           -->  Defines the path to the log file.
echo Created directory %targetDir% >> "%logFile%"                         -->  Logs the creation of the directory.
echo Directory %targetDir% already exists >> "%logFile%":                 -->  prompts if the directory already exists.
echo Copied %%f to %targetDir%!filename!_!date!!extension! >> "%logFile%" -->  Logs each file copy operation.
echo All files have been copied and renamed. >> "%logFile%"               -->  Logs the completion message to the log file.

for /f "tokens=2 delims==" %%i in ('"wmic os get localdatetime /value"') do set datetime=%%i  -->  Retrieves the current date and time from the system.
set date=!datetime:~0,4!-!datetime:~4,2!-!datetime:~6,2!                                      --> Formats the date into YYYY-MM-DD.
set sourceDir and set targetParentDir                                                         --> Define the source directory and the parent directory where 
                                                                                                  the new dated directory will be created.
set targetDir=%targetParentDir%%date%                                                         --> Constructs the path for the new dated directory.

if not exist "%targetDir%" (mkdir "%targetDir%")     --> Creates the target directory if it doesn't exist.
for %%f in ("%sourceDir%*") do                       -->Loops through each file in the source directory.
set "filename=%%~nf"                                 --> Extracts the file name without the path and extension.
set "extension=%%~xf"                                --> Extracts the file extension.
move "%%f" "%targetDir%!filename!_!date!!extension!" -->  Moves the file to the target directory, appending the date to the file name.


: A label (function) to get the current timestamp in the format YYYY-MM-DD_HH-MM-SS.

: for /f "tokens=1-6 delims=.:/ " %%a in ("%date% %time%") do set ts=%%a-%%b-%%c_%%d-%%e-%%f: 
This Extracts the current date and time components and formats them.

call - 
: Calls the timestamp function to set the ts variable before logging each entry.
echo [%ts%] ... >> "%logFile%": Logs the message with the timestamp.
