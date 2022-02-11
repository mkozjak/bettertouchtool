tell application "Safari"
    -- github issues: document.getElementsByClassName('previous_page')[0].click()
    -- google results: document.getElementById('pnprev').click()
    set currentURL to (get URL of current tab of window 1)

    tell application "BetterTouchTool"
        set action to get_string_variable "pageAction"
    end tell

    set pageMode to do shell script "if [[ " & ¬
        quoted form of currentURL & ¬
        " =~ google\\..+/search ]]; then echo google; elif [[ " & ¬
        quoted form of currentURL & ¬
        " =~ github.com/.+/issues ]]; then echo github; fi"

    if pageMode is equal to "google" then
        if action is equal to "previous" then
            set element to "pnprev"
        else
            set element to "pnnext"
        end if

        do JavaScript "document.getElementById('" & element & "').click();" in current tab of window 1
        return
    else if pageMode is equal to "github" then
        if action is equal to "previous" then
            set element to "previous_page"
        else
            set element to "next_page"
        end if

        do JavaScript "document.getElementsByClassName('" & element & "')[0].click()" in current tab of window 1
        return
    end if
end tell
