tell application "Shortcuts Events"
    set focus to run shortcut "Get Current Focus"

    if length of focus is greater than 0 then
        set focusString to item 1 of focus as string

        if focusString is equal to "Do Not Disturb" then
            return "enabled"
        else
            return "disabled"
        end if
    else
        return "disabled"
    end if
end tell
