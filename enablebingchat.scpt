tell application "Safari"
    activate
    tell application "System Events"
        tell process "Safari"
            click menu item "User Agent" of menu "Develop" of menu bar 1
            click menu item "Microsoft Edge — Windows" of menu 1 of menu item "User Agent" of menu "Develop" of menu bar 1
        end tell
    end tell
end tell

