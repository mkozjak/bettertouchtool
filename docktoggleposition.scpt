-- Check active displays
set displayInfo to do shell script "system_profiler SPDisplaysDataType | grep 'Resolution' | wc -l | xargs"
set displayCount to displayInfo as integer

tell application "System Events" to tell dock preferences
	if displayCount > 1 then
		-- External display connected
		set screen edge to right
		set dock size to 1
		set autohide to true
	else
		-- Only built-in display active
		set screen edge to bottom
		set dock size to 0.3
		set autohide to true
	end if
end tell
