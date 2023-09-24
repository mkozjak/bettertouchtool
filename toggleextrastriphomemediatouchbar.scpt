tell application "BetterTouchTool"
	set enabled to get_string_variable "extraStripEnabled"

	if enabled is "true" then
		set switchVal to 0
		set_string_variable "extraStripEnabled" to "false"
	else
		set switchVal to 1
		set_string_variable "extraStripEnabled" to "true"
	end if

	update_trigger "1174E1B5-CE78-4176-9F7C-086E490E6E71" json "{\"BTTEnabled2\": " & switchVal & "}"
	update_trigger "9303727C-B6E5-44F5-9DB4-26E9C4CAE3C9" json "{\"BTTEnabled2\": " & switchVal & "}"
	update_trigger "EFBC66DC-6E3D-490B-9A7B-3618D48B9AF3" json "{\"BTTEnabled2\": " & switchVal & "}"
	update_trigger "6A7E6A84-A2E7-40BF-9AE1-7F2171AE3CDE" json "{\"BTTEnabled2\": " & switchVal & "}"
	update_trigger "E25B9302-32D5-4F91-ADC9-BFBF40D5A3EC" json "{\"BTTEnabled2\": " & switchVal & "}"
end tell
