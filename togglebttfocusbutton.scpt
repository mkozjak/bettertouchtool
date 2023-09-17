tell application "BetterTouchTool"
	set focusValue to get_number_variable "SystemDoNotDisturbState"

	if focusValue is equal to 0
		update_trigger "B18FB05B-9D3D-4CD4-8B32-8D7393FE7E5F" json "{\"BTTTriggerConfig\": {\"BTTTouchBarButtonColor\": \"75, 64, 224, 255\"}}"
	else
		update_trigger "B18FB05B-9D3D-4CD4-8B32-8D7393FE7E5F" json "{\"BTTTriggerConfig\": {\"BTTTouchBarButtonColor\": \"55, 55, 55, 255\"}}"
	end if
end tell