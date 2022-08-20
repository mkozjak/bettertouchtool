-- Empties the trash bin without warning the user
-- To be used with a two finger force-click on the macOS Dock Bin icon
-- Adapted from https://community.folivora.ai/t/enhanced-dock-for-macos/22364

tell application "System Events" to tell process "Dock" to try
    set frontmost to true
    delay 0.2

    set l to list 1
    try
        set s to item 1 of (first UI element whose selected is true) of l
        set {AppNm, AppSr} to {name of s, subrole of s}
    on error
        set AppNm to name of value of attribute "AXFocusedUIElement"
        set AppSr to subrole of item 1 of UI element AppNm of l
    end try

    try
        set AppSt to value of attribute "AXIsApplicationRunning" of UI element AppNm of l
    end try
on error
    beep
    return
end try

if AppSr is "AXTrashDockItem" then
    tell application "Finder"
        if (warns before emptying of trash) then
            set warns before emptying of trash to false

            try
                empty trash
            end try

            set warns before emptying of trash to true
        else
            empty trash
        end if
    end tell
end if
