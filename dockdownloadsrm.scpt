tell application "BetterTouchTool"
	set inputString to get_string_variable "hovered_element_details"
	
	-- Extract AXDescription
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to "AXDescription:  \""
	set textItems to text items of inputString
	
	if (count of textItems) > 1 then
		set descriptionPart to item 2 of textItems
		set AppleScript's text item delimiters to "\""
		set descriptionValue to text item 1 of descriptionPart
		
		tell application "Finder"
			set downloadsFolder to ((path to downloads folder) as text)
			set targetFile to downloadsFolder & descriptionValue as alias
			delete targetFile
		end tell
	end if
	
	-- Restore original delimiters
	set AppleScript's text item delimiters to oldDelimiters
end tell
