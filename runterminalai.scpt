tell application "Terminal"
    activate
    delay 0.3

    set foundAI to false

    repeat with w in windows
        repeat with t in tabs of w
            set tabTTY to tty of t
            set ttyName to do shell script "/usr/bin/basename " & quoted form of tabTTY
            set markerPath to "/tmp/codex-ai." & ttyName

            set checkCommand to "/bin/test -f " & quoted form of markerPath
            set checkCommand to checkCommand & " && /bin/ps -t " & quoted form of ttyName
            set checkCommand to checkCommand & " -o command= | /usr/bin/grep -q '[c]odex'"
            set checkCommand to checkCommand & " && /usr/bin/printf yes || /usr/bin/printf no"
            set isLive to do shell script checkCommand

            if isLive is "yes" then
                set selected tab of w to t
                set index of w to 1
                set foundAI to true
                exit repeat
            end if
        end repeat

        if foundAI then exit repeat
    end repeat

    if not foundAI then
        if (count of windows) = 0 then
            do script "ai"
        else
            tell application "System Events" to keystroke "t" using command down
            delay 0.2
            do script "ai" in selected tab of front window
        end if
    end if
end tell
