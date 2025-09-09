tell application "BetterTouchTool"
	set currentVal to get_number_variable "dell_brightness"
end tell

if currentVal is missing value then
	return
end if

set newVal to currentVal - 10
if newVal < 0 then set newVal to 0

do shell script "/opt/homebrew/bin/m1ddc display 1 set luminance " & newVal

tell application "BetterTouchTool"
	set_persistent_number_variable "dell_brightness" to newVal
end tell
