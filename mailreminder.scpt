tell application "Mail"
    try
        set amount_input to display dialog "Remind me about this message in:" default answer "1" with icon note with title "Snooze message" buttons {"Days", "Hours", "Cancel"} default button "Days" cancel button "Cancel"
        set amount_integer to (text returned of amount_input) as integer
        set amount_type to (button returned of amount_input) as string
    on error
        return
    end try

    set these_messages to selected messages of first message viewer
    set the message_count to the count of these_messages

    repeat with i from 1 to the message_count
        set this_message to item i of these_messages

        try
            set this_subject to (subject of this_message) as Unicode text
            set message_id to do shell script "/opt/homebrew/bin/python2 -c 'import sys, urllib; print urllib.quote(sys.argv[1])' " & (message id of this_message)
            set message_link to "message://%3C" & message_id & "%3E"
        end try
    end repeat

    if amount_type = "Days" then
        set due_date to (current date) + 60 * 60 * 24 * amount_integer

        tell application "Reminders"
            make new reminder at end with properties {name:this_subject, allday due date:due_date, body:message_link}
        end tell
    else
        if amount_type = "Hours" then
            set due_date to (current date) + 60 * 60 * amount_integer

            tell application "Reminders"
                make new reminder at end with properties {name:this_subject, due date:due_date, body:message_link}
            end tell
        end if
    end if
end tell
