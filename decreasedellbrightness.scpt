tell application "BetterTouchTool"
	set currentVal to get_number_variable "dell_brightness"
end tell

if currentVal is missing value then
	return
end if

set newVal to currentVal - 6
if newVal < 0 then set newVal to 0

do shell script "/opt/homebrew/bin/m1ddc display 1 set luminance " & newVal

tell application "BetterTouchTool"
	set_persistent_number_variable "dell_brightness" to newVal

	-- snap to nearest 6.25% step (1/16) to properly show on OSD
    set stepSize to 6.25
    set boxCount to round (newVal / stepSize)
    set snappedPerc to boxCount * stepSize

    -- round down to whole number (no decimals)
    set snappedPercInt to (snappedPerc div 1)

   	set_number_variable "dell_brightness_snapped" to snappedPercInt
end tell
