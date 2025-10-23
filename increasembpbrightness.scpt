-- get current brightness for display 1
set currentVal to do shell script "/usr/local/bin/brightness -l 2>/dev/null | grep 'built-in' -A 1 | tail -n 1 | awk '{ print $NF }' | sed 's/\\./,/g'"

-- convert to number
set currentFloat to currentVal as real

-- increment by 0.0625
set newVal to currentFloat + (0.0625 as real)

-- clamp to 1.0 max
if newVal > 1 then set newVal to 1
set newValStr to newVal as string
set newValStr to replace_chars(newValStr, ",", ".")

-- apply new brightness
do shell script "/usr/local/bin/brightness -d 1 " & newValStr

set perc to newVal*100
set percRound to (round perc rounding up)

tell application "BetterTouchTool"
	set_persistent_number_variable "mbp_brightness" to percRound

	-- snap to nearest 6.25% step (1/16) to properly show on OSD
    set stepSize to 6.25
    set boxCount to round (perc / stepSize)
    set snappedPerc to boxCount * stepSize

    -- round down to whole number (no decimals)
    set snappedPercInt to (snappedPerc div 1)

    set_number_variable "mbp_brightness_snapped" to snappedPercInt
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
