if application "BetterTouchTool" is running then
    tell application "BetterTouchTool"
    	-- trigger BTT show action
        set isVisible to get_number_variable "BTTTouchBarVisible"

        if isVisible is 0 then
        	trigger_action "{\"BTTPredefinedActionType\":282}"
            set_string_variable "customVariable1" to "GitDirectory"
        end if
    end tell
end if