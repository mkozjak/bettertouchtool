tell application "BetterTouchTool"
	set currentVal to get_number_variable "dell_brightness"
end tell

if currentVal is missing value then
	return
end if

set newVal to currentVal + 5
if newVal > 100 then set newVal to 100

do shell script "/opt/homebrew/bin/m1ddc display 1 set luminance " & newVal

tell application "BetterTouchTool"
	set_persistent_number_variable "dell_brightness" to newVal
end tell
