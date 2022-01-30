tell application "Finder"
	set currentDir to target of Finder window 1 as alias
end tell
set mydir to POSIX path of currentDir


tell application "iTerm"
	if (count of window) = 0 then
		set awindow to (make new window)
	end if
	repeat with awindow in windows
		if profile name of current session of awindow = "Default" then
			set currwindo to awindow
			exit repeat
		end if
	end repeat
	
	
	tell awindow
		set mytab to create tab with default profile
		tell (first session of mytab)
			write text "cd '" & mydir & "'"
		end tell
	end tell
	activate
end tell
