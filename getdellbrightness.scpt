set luminanceValue to do shell script "/opt/homebrew/bin/m1ddc display 1 get luminance | awk '{print $NF}'"
set luminanceInt to luminanceValue as integer

if luminanceInt is not 0 then
    tell application "BetterTouchTool"
    	set_persistent_number_variable "dell_brightness" to luminanceInt
        set check to get_number_variable "dell_brightness"
        log check
    end tell
end if
