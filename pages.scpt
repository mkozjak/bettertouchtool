tell application "Safari"
    -- github issues: document.getElementsByClassName('previous_page')[0].click()
    -- google search results: document.getElementById('pnprev').click()
    -- google images results qs: tbm=isch
    set currentURL to (get URL of current tab of window 1)

    tell application "BetterTouchTool"
        set action to get_string_variable "pageAction"
    end tell

    set pageMode to do shell script ¬
        "if [[ " & quoted form of currentURL & " =~ google\\..+/search ]]; then " & ¬
            "if [[ " & quoted form of currentURL & " =~ tbm=isch ]]; then echo googleimages; else echo googlesearch; fi; " & ¬
        "elif [[ " & quoted form of currentURL & " =~ github.com/.+/issues ]]; then echo githubissues; " & ¬
        "fi"

    if pageMode is equal to "googlesearch" then
        if action is equal to "previousPage" then
            set element to "pnprev"
        else if action is equal to "nextPage" then
            set element to "pnnext"
        end if

        do JavaScript "document.getElementById('" & element & "').click();" in current tab of window 1
        return
    else if pageMode is equal to "googleimages" then
        if action is equal to "openImage" then
            do JavaScript "var items = document.querySelectorAll(':hover'); for (let c = 0; c < items.length; c++) { " & ¬
                "if (items[c].nodeName === 'A') { items[c].click(); " & ¬
                "var p = new URL(items[c].href); var n = p.searchParams.get('imgurl'); " & ¬
                "window.open(n, '_self'); break } };" in current tab of window 1
        end if

        return
    else if pageMode is equal to "githubissues" then
        if action is equal to "previousPage" then
            set element to "previous_page"
        else if action is equal to "nextPage" then
            set element to "next_page"
        end if

        do JavaScript "document.getElementsByClassName('" & element & "')[0].click()" in current tab of window 1
        return
    end if
end tell
