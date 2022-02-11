tell application "Safari"
    -- github issues: document.getElementsByClassName('next_page')[0].click()
    -- google results: document.getElementById('pnnext').click()
    set currentURL to (get URL of current tab of window 1)

    set isGoogle to do shell script "echo " & quoted form of currentURL & " | egrep 'https://(?:www.)?google\\..+/search' > /dev/null 2>&1; if [[ $? == 0 ]]; then echo true; else echo false; fi"

    if isGoogle is equal to "true" then
        set pageMode to "googlesearch"
        do JavaScript "document.getElementById('pnnext').click();" in current tab of window 1
        return
    end if

    set isGitHub to do shell script "echo " & quoted form of currentURL & " | egrep 'https://(?:www.)?github.com/.+/issues' > /dev/null 2>&1; if [[ $? == 0 ]]; then echo true; else echo false; fi"

    if isGitHub is equal to "true" then
        set pageMode to "githubissues"
        do JavaScript "document.getElementsByClassName('next_page')[0].click()" in current tab of window 1
        return
    end if
end tell
