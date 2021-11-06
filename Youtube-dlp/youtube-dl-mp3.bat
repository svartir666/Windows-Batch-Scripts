call preamble.bat

set /p URL="Video URL: >"
bin\yt-dlp.exe --extract-audio --audio-format mp3 --cookies-from-browser firefox --sponsorblock-remove all --no-check-certificate --output "%%(playlist_index)s %%(title)s.%%(ext)s" --paths "%downloadDir%" "%URL%"
pause