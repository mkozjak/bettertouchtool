tell application "BetterTouchTool"
	set OutputVolume to get_number_variable "BTTOutputVolume"
	set BTTCurrentAudioOutputDevice to get_string_variable "BTTCurrentAudioOutputDevice"
end tell

-- Increase the system output volume by 10%
set currentVolume to output volume of (get volume settings)
set newVolume to currentVolume + (currentVolume * 0.1)
if newVolume > 100 then set newVolume to 100
set volume output volume newVolume

-- Calculate the new volume as a percentage for the OSD
set volumePercent to (output volume of (get volume settings))

-- Set the OSD position (replace with your desired value or fetch from BTT if available)
set volume_osd_position to "center"

do shell script "/usr/local/bin/volume-control-osd --volume " & volumePercent & " --title " & quoted form of BTTCurrentAudioOutputDevice & " --position " & volume_osd_position
