-- Capture a screenshot movie, then transcode and downscale with ffmpeg to save space
-- Result: ~/Desktop/TheWitcher3_<timestamp>_720p.mp4

set timeStamp to do shell script "date +'%Y-%m-%d_%H-%M-%S'"
set desktopPath to POSIX path of (path to desktop folder)
set rawPath to desktopPath & "TheWitcher3_" & timeStamp & "_raw.mov"
set finalPath to desktopPath & "TheWitcher3_" & timeStamp & "_720p.mp4"

-- Capture (give a short delay before capture so you can switch to the app)
do shell script "/bin/sleep 2 && /usr/sbin/screencapture -v -V 5 -k " & quoted form of rawPath

-- Transcode and downscale to 1280x720 using ffmpeg. This uses bash -lc so ffmpeg in Homebrew PATH is found.
set ffCmd to "while [ ! -f " & quoted form of rawPath & " ]; do sleep 0.1; done; /opt/homebrew/bin/ffmpeg -y -i " & quoted form of rawPath & " -vf \"scale=1280:-2\" -c:v libx264 -preset slow -crf 20 -c:a aac -b:a 160k " & quoted form of finalPath & " && rm -f " & quoted form of rawPath

do shell script "/usr/bin/env bash -lc " & quoted form of ffCmd
