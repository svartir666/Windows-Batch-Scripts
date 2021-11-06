cls
@echo off

set downloadDir="%USERPROFILE%\Downloads\youtube-dl"
mkdir "%downloadDir%"

bin\yt-dlp.exe --update