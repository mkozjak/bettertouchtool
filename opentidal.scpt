tell application "System Events"
    if (get name of every application process) contains "Tidal" then
        tell process "TIDAL"
            click menu item 0 of menu "Playback" of menu bar 1
        end tell
    else
        tell application "Tidal" to activate
    end if
end tell
