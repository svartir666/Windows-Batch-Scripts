call preamble.bat

set /p URL="Video URL: >"
bin\yt-dlp.exe --cookies-from-browser firefox --paths "%downloadDir%" "%URL%"