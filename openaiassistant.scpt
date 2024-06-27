property wantedURL : "http://localhost:34298"

tell application "Safari"
	activate

	set theURLs to (get URL of every tab of every window)

	repeat with x from 1 to length of theURLs
		set tmp to item x of theURLs
		repeat with y from 1 to length of tmp
			if item y of tmp contains wantedURL then
				set the index of window x to 1

				tell window 1
					if index of current tab is not y then set current tab to tab y
					return 0
				end tell
			end if
		end repeat
	end repeat

	--if we get here the tab wasn't open so...
	tell window 1
		set current tab to (make new tab with properties {URL:wantedURL})
	end tell
end tell
