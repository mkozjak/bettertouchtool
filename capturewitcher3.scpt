-- 1. Configuration
set albumName to "The Witcher 3"
set tempFolder to POSIX path of (path to temporary items)
set timeStamp to do shell script "date +'%Y-%m-%d_%H-%M-%S'"
set tempFilePath to tempFolder & "TheWitcher3_" & timeStamp & ".mov"

-- 2. Programmatically record screen 0 for 5 seconds (silent, background)
-- -v: video mode, -V 5: duration 5s, -k: hide mouse cursor (optional)
do shell script "/bin/sleep 2 && /usr/sbin/screencapture -v -V 5 -k " & quoted form of tempFilePath

-- 3. Import the generated video directly into Photos
tell application "Photos"
	-- Import video into the specific album
	import (POSIX file tempFilePath as alias) into album albumName skip check duplicates true
end tell

-- 4. Clean up temporary file from disk
do shell script "rm " & quoted form of tempFilePath
