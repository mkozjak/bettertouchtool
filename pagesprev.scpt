tell application "Safari"
    -- github issues: document.getElementsByClassName('previous_page')[0].click()
    -- google results: document.getElementById('pnprev').click()
    set currentURL to (get URL of current tab of window 1)

    set pageMode to do shell script "if [[ " & quoted form of currentURL & " =~ google\\..+/search ]]; then echo google; elif [[ " & quoted form of currentURL & " =~ github.com/.+/issues ]]; then echo github; fi"

    if pageMode is equal to "google" then
        do JavaScript "document.getElementById('pnprev').click();" in current tab of window 1
        return
    else if pageMode is equal to "github" then
        do JavaScript "document.getElementsByClassName('previous_page')[0].click()" in current tab of window 1
        return
    end if
end tell
