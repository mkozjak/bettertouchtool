tell application "BetterTouchTool"
	set curVolume to get volume settings

	if output muted of curVolume is false then
		update_trigger "1E1CA1A9-F8F0-418B-B1F5-6392A0E23825" json "{\"BTTTriggerConfig\": {\"BTTTouchBarItemSFSymbolDefaultIcon\": \"speaker.wave.2.fill\"}}"
	else
		update_trigger "1E1CA1A9-F8F0-418B-B1F5-6392A0E23825" json "{\"BTTTriggerConfig\": {\"BTTTouchBarItemSFSymbolDefaultIcon\": \"speaker.slash.fill\"}}"
	end if
end tell
