if application "BetterTouchTool" is running then
    tell application "BetterTouchTool"
	    -- trigger BTT hide action
        set isVisible to get_number_variable "BTTTouchBarVisible"
        
        if isVisible is 1 then
        	trigger_action "{\"BTTPredefinedActionType\":283}"
            set_string_variable "customVariable1" to ""
        end if
    end tell
end if
