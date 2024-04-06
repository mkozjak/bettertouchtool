tell application "System Events"
    set defaultPlayer to "TIDAL"

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

    if (get name of every application process) contains "Logic Pro X" then
        tell process "Logic Pro"
            set frontmost to true
            key code 49
        end tell

        set visible of process "Logic Pro" to false
        return
    end if

    if (get name of every application process) contains "Swinsian" then
        tell process "Swinsian"
            click menu item 0 of menu "Control" of menu bar 1
        end tell

        return
    end if

    if (get name of every application process) contains "IINA" then
        tell process "IINA"
            click menu item 0 of menu "Playback" of menu bar 1
        end tell

        return
    end if

    if (get name of every application process) contains "Tidal" then
        tell process "TIDAL"
            click menu item 0 of menu "Playback" of menu bar 1
        end tell

        return
    end if

    if (get name of every application process) contains "Deezer" then
        tell application "Shortcuts Events" to run shortcut "Play/Pause"

        return
    end if

    if (get name of every application process) contains "Music" then
        tell app "Music" to playpause
        return
    end if

    # MPD or CMUS?
    set mpdRunning to false
    set cmusRunning to false

    try
        do shell script "/opt/homebrew/bin/cmus-remote -C"
        set cmusRunning to true
    end try

    try
        do shell script "nc -z -w 2 localhost 6600"
        set mpdRunning to true
    end try

    if cmusRunning then
        do shell script "/opt/homebrew/bin/cmus-remote --pause"
    else if mpdRunning then
        do shell script "echo \"pause\" | nc localhost 6600"
    else
        click UI element defaultPlayer of list 1 of application process "Dock"
    end if
end tell
