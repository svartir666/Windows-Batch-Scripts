@echo off
SETLOCAL EnableDelayedExpansion
cls

REM Show available target drives
echo -------------------------------------------------------------------------------
echo Available Target Drives:
echo -------------------------------------------------------------------------------
wmic logicaldisk get deviceid, volumename, description

set /p DEST_DRIVE="Enter Drive Letter (W/o doublepoint or backslash): "

REM Check if drive is valid backup drive
if not exist "%DEST_DRIVE%:\backupdrive.txt" (
    echo backupdrive.txt not found. Exiting...
	pause
	exit
)

REM Get Local Date and Time in ISO-Format
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ISODATE=%%j
set ISODATE=%ISODATE:~0,4%-%ISODATE:~4,2%-%ISODATE:~6,2%_%ISODATE:~8,2%%ISODATE:~10,2%%ISODATE:~12,2%

REM Backup
for /f "tokens=*" %%i in (directories.txt) do (
	set SOURCE=%%~i
	set TARGET=%DEST_DRIVE%:\!SOURCE::=!
	set TARGET=!TARGET:\\=!
	
	echo mkdir "!TARGET!"
	mkdir "!TARGET!"
	
	echo robocopy "!SOURCE!" "!TARGET!"
	robocopy "!SOURCE! " "!TARGET! " /A-:SH /MIR /FFT /R:3 /W:10 /Z /XJD /MT:8 /NP /NDL /log+:"%DEST_DRIVE%:\log_%ISODATE%.txt" /TEE
)

pause