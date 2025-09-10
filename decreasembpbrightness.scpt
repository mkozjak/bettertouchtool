-- get current brightness for display 1
set currentVal to do shell script "/usr/local/bin/brightness -l 2>/dev/null | grep 'display 1: brightness' | awk '{ print $NF }' | xargs printf \"%.1f\\n\" | sed 's/\\./,/g'"

-- convert to number
set currentFloat to currentVal as real

-- decrement by 0.1
set newVal to currentFloat - (0.1 as real)

-- clamp to 0.0 max
if newVal < 0 then set newVal to 0
set newValStr to newVal as string
set newValStr to replace_chars(newValStr, ",", ".")

-- apply new brightness
do shell script "/usr/local/bin/brightness -d 1 " & newValStr

tell application "BetterTouchTool"
	set_persistent_number_variable "mbp_brightness" to newVal*100
end tell

-- helper function
on replace_chars(theText, searchString, replaceString)
	set AppleScript's text item delimiters to searchString
	set theItems to every text item of theText
	set AppleScript's text item delimiters to replaceString
	set theText to theItems as string
	set AppleScript's text item delimiters to ""
	return theText
end replace_chars
