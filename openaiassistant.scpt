tell application "Safari"
	activate
	tell window 1
		set current tab to (make new tab with properties {URL:"http://localhost:34298"})
	end tell
end tell
