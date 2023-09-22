tell application "Shortcuts Events"
    tell application "BetterTouchTool"
        set manualToggle to get_string_variable "customVariable2"
    end tell

    set focus to run shortcut "Get Current Focus"

    if length of focus is greater than 0 then
        set focusString to item 1 of focus as string

        if focusString is equal to "Do Not Disturb" then
            if manualToggle is equal to "true" then
                tell application "BetterTouchTool"
                    update_trigger "E5611CB3-DE4D-4980-BB12-A93E79CA040A" json "{\"BTTTriggerConfig\": {\"BTTTouchBarFontColor\": \"124, 113, 255, 255\"}}"
                end tell
            end if

            return "enabled"
        else
            if manualToggle is equal to "true" then
                tell application "BetterTouchTool"
                    update_trigger "E5611CB3-DE4D-4980-BB12-A93E79CA040A" json "{\"BTTTriggerConfig\": {\"BTTTouchBarFontColor\": \"255, 255, 255, 255\"}}"
                end tell
            end if

            return "disabled"
        end if
    else
        if manualToggle is equal to "true" then
            tell application "BetterTouchTool"
                update_trigger "E5611CB3-DE4D-4980-BB12-A93E79CA040A" json "{\"BTTTriggerConfig\": {\"BTTTouchBarFontColor\": \"255, 255, 255, 255\"}}"
            end tell
        end if

        return "disabled"
    end if
end tell
