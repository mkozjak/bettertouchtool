tell application "BetterTouchTool"
	set curVolume to get volume settings
	-- 0-33 (1); 34-66 (2); 67-100 (3)

	if output muted of curVolume is true
		return "{\"sf_symbol_name\": \"speaker.slash.fill\", \"text\": \"Volume Control\", \"icon_height\": 24, \"icon_width\": 24}"
	end if

	set volumeLevel to output volume of curVolume

	if volumeLevel is less than 1 then
		return "{\"sf_symbol_name\": \"speaker.slash.fill\", \"text\": \"Volume Control\", \"icon_height\": 24, \"icon_width\": 24}"
	else if volumeLevel is less than 34 then
		return "{\"sf_symbol_name\": \"speaker.wave.1.fill\", \"text\": \"Volume Control\", \"icon_height\": 24, \"icon_width\": 24}"
	else if volumeLevel is less than 67 then
		return "{\"sf_symbol_name\": \"speaker.wave.2.fill\", \"text\": \"Volume Control\", \"icon_height\": 24, \"icon_width\": 24}"
	else
		return "{\"sf_symbol_name\": \"speaker.wave.3.fill\", \"text\": \"Volume Control\", \"icon_height\": 24, \"icon_width\": 24}"
	end if
end tell
