-- set togglebttmutebuttonicon to POSIX file "/opt/dev/github.com/mkozjak/bettertouchtool/togglebttmutebuttonicon.scpt"
-- set togglebttfocusbutton to POSIX file "/opt/dev/github.com/mkozjak/bettertouchtool/togglebttfocusbutton.scpt"

-- run script togglebttmutebuttonicon
-- run script togglebttfocusbutton

tell application "BetterTouchTool"
    set_string_variable "VolumeGroupOpen" to "false"
    set_string_variable "BrightnessGroupOpen" to "false"
    set_string_variable "ExtraStripGroupOpen" to "false"
    set_string_variable "MusicControlsGroupOpen" to "false"
end tell
