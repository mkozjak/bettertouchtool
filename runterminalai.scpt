tell application "Terminal"
	activate
	delay 0.3

	set foundAI to false

	repeat with w in windows
		-- Terminal can include an incomplete window entry in this list.
		try
			set windowTabs to tabs of w
		on error
			set windowTabs to {}
		end try
		repeat with t in windowTabs
			set tabTTY to tty of t
			set ttyName to do shell script "/usr/bin/basename " & quoted form of tabTTY
			set markerPath to "/tmp/codex-ai." & ttyName

			set checkCommand to "/bin/test -f " & quoted form of markerPath
			set checkCommand to checkCommand & " && /bin/ps -t " & quoted form of ttyName
			-- A stale marker can point to a TTY that has since been reused by
			-- another Codex session. The ai function always uses this workspace.
			set checkCommand to checkCommand & " -o command= | /usr/bin/awk '/codex/ && /\\/codex-chat\\.[^[:space:]\\/]+/ { found = 1 } END { exit !found }'"
			set checkCommand to checkCommand & " && /usr/bin/printf yes || /usr/bin/printf no"
			set isLive to do shell script checkCommand

			if isLive is "yes" then
				set selected tab of w to t
				set miniaturized of w to false
				set index of w to 1
				set foundAI to true
				exit repeat
			end if
		end repeat

		if foundAI then exit repeat
	end repeat

	if not foundAI then
		do script in new tab "ai"
	end if
end tell
