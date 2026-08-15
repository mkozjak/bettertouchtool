-- 1. Configuration
set albumName to "The Witcher 3"
set timeStamp to do shell script "date +'%Y-%m-%d_%H-%M-%S'"
set tempFilePath to (POSIX path of (path to movies folder)) & "TheWitcher3_" & timeStamp & ".mov"

-- 2. Record screen for 5 seconds (2s delay to let BTT UI settle first)
do shell script "/bin/sleep 2 && /usr/sbin/screencapture -v -V 5 -k " & quoted form of tempFilePath

-- 3. Verify the file was actually created before importing
set fileExists to (do shell script "test -f " & quoted form of tempFilePath & " && echo yes || echo no")
if fileExists is not "yes" then
	error "screencapture did not produce a file at " & tempFilePath
end if

-- 4. Find or create the target album in Photos
tell application "Photos"
	set targetAlbum to missing value
	repeat with a in (every album)
		if name of a is albumName then
			set targetAlbum to a
			exit repeat
		end if
	end repeat
	if targetAlbum is missing value then
		set targetAlbum to make new album named albumName
	end if
end tell

-- 5. Import into Photos
tell application "Photos"
	import (POSIX file tempFilePath as alias) into targetAlbum skip check duplicates true
end tell

-- 6. Clean up temp file now that Photos has finished importing
do shell script "rm -f " & quoted form of tempFilePath
