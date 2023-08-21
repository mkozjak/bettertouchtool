--------------------------------------------------------------------------------
# Auth: Yohanes Bandung Bondowoso, Mario Kozjak
# dCre: 2021-07-11 20:18
# dMod: 2023-08-19 15:51
# Appl: System Events, PIPAgent, Safari
# Task: Toggle Picture in Picture (PiP) on and off
# Libs: None
# Osax: None
# Aojc: True
# Tags: @Applescript, @Script, @System_Events, @PictureInPicture, @PiP, @Safari
# Vers: 1.05
--------------------------------------------------------------------------------

try
	if application "PIPAgent" is running then
		tell application "System Events"
			click button 3 of window "PIP" of application process "PIPAgent"
		end tell
	else
		error "Can’t get application process"
	end if
on error pipErrMsg

	if pipErrMsg contains "Can’t get application process" or pipErrMsg contains "Can’t get window" then
		try
			tell application "Safari"
				set docItem to first item of documents
				set tabName to name of docItem
			end tell

			tell application "System Events"
				tell application process "Safari"
					set aWindow to window 1

					tell application "System Events"
						perform action "AXShowMenu" of button 2 of UI element tabName of UI element 1 of group 3 of toolbar 1 of aWindow
					end tell

					delay 0.2
					click menu item "Enter Picture in Picture" of menu 1 of group 3 of toolbar 1 of window tabName
				end tell
			end tell

			do shell script "killall System\\ Events"
		on error safariErrMsg
			return "Error Level::Safari:" & space & safariErrMsg
		end try
	else
		return "Error Level::PIP Agent:" & space & pipErrMsg
	end if
end try
