set timeStamp to do shell script "date +'%Y-%m-%d_%H-%M-%S'"
set outputPath to (POSIX path of (path to desktop folder)) & "TheWitcher3_" & timeStamp & ".mov"

do shell script "/bin/sleep 2 && /usr/sbin/screencapture -v -V 5 -k " & quoted form of outputPath
