tell application "System Events"
    if frontmost of application "Tidal" then
        tell process "TIDAL"
            click menu item 0 of menu "Playback" of menu bar 1
        end tell
        return
    end if

    if (get name of every application process) contains "Safari" then
        tell application "Safari"
            repeat with t in tabs of windows
                if URL of t contains "youtube.com/watch" then
                    tell t
                        do JavaScript "document.querySelector('.ytp-play-button')?.click();"
                        return
                    end tell
                end if
            end repeat
        end tell
    end if

    if (get name of every application process) contains "Tidal" then
        tell process "TIDAL"
            click menu item 0 of menu "Playback" of menu bar 1
        end tell
    else
        tell application "Tidal" to activate
    end if
end tell
