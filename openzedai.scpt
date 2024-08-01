if application "Zed" is not running
    do shell script "/opt/homebrew/bin/zed /opt/dev/private/.zedai"
    return
end if

tell application "System Events"
    tell process "Zed"
        set myWindows to windows

        repeat with aWindow in myWindows
            if aWindow's title contains ".zedai" then
                tell application "BetterTouchTool"
                    trigger_named "Activate Zed Assistant"
                end tell

                return
            end if
        end repeat

        do shell script "/opt/homebrew/bin/zed /opt/dev/private/.zedai"

        tell application "BetterTouchTool"
            trigger_named "Resize Zed Assistant"
        end tell
    end tell
end tell
