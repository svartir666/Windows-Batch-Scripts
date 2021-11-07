@echo off
cls

del job.rcj

REM Source Directory
echo /SD:%~1 >> job.rcj
REM Destination Directory
echo /DD:%~2 >> job.rcj

REM Include These Files
echo /IF >> job.rcj

REM eXclude symbolic links for Directories and Junction points
echo /XJD >> job.rcj

REM eXclude Directories matching these names
echo /XD >> job.rcj
for /f "tokens=*" %%i in (exclusions-xd.txt) do (
	echo %%i >> job.rcj
)

REM eXclude Files matching these names
echo /XF >> job.rcj
for /f "tokens=*" %%i in (exclusions-xf.txt) do (
	echo %%i >> job.rcj
)

REM copy Subdirectories, but not empty ones.
echo /S >> job.rcj
REM copy subdirectories, including Empty ones.
echo /E >> job.rcj
REM what to COPY for directories (default is /DCOPY:DA).
echo /DCOPY:DA >> job.rcj
REM what to COPY for files (default is /COPY:DAT).
echo /COPY:DAT >> job.rcj
REM delete dest files/dirs that no longer exist in source.
echo /PURGE >> job.rcj
REM MIRror a directory tree (equivalent to /E plus /PURGE).
echo /MIR >> job.rcj
REM assume FAT File Times (2-second granularity).
echo /FFT >> job.rcj
REM remove the given Attributes from copied files.
echo /A-:SH >> job.rcj
REM copy files in restartable mode.
echo /Z >> job.rcj

REM number of Retries on failed copies: default 1 million.
echo /R:3 >> job.rcj
REM Wait time between retries: default is 30 seconds.
echo /W:5 >> job.rcj

REM No Directory List - don't log directory names.
echo /NDL >> job.rcj
REM No Progress - don't display percentage copied.
echo /NP >> job.rcj
REM output status to LOG file (append to existing log).
echo /LOG+:log.log >> job.rcj
REM output to console window, as well as the log file.
echo /TEE >> job.rcj