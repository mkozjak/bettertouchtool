-- mbptogglemute.scpt
-- Toggles mute and shows OSD with current volume and output device

tell application "System Events"
    set currentVolume to output volume of (get volume settings)
    set isMuted to output muted of (get volume settings)
    set newMute to not isMuted
    set volume output muted newMute
end tell

delay 0.1 -- Give the system a moment to update

tell application "System Events"
    set currentVolume to output volume of (get volume settings)
    set isMuted to output muted of (get volume settings)
end tell

set displayVolume to currentVolume
if isMuted then
    set displayVolume to 0
end if

-- Get current output device name
do shell script "/opt/homebrew/bin/SwitchAudioSource -c | head -n1 | sed 's/^[* ]*//'"
set outputDevice to the result

-- Show OSD
do shell script "/usr/local/bin/volume-control-osd --volume " & displayVolume & " --title '" & outputDevice & "' --position top-center"
