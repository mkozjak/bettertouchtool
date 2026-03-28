-- Configuration
property notificationTimeout : 6
property alerterPath : "/opt/homebrew/bin/alerter"
property finderIcon : "/opt/dev/github.com/mkozjak/bettertouchtool/assets/finder.webp"
property jellyfinIcon : "/opt/dev/github.com/mkozjak/bettertouchtool/assets/jellyfin.png"
property appleMusicIcon : "/opt/dev/github.com/mkozjak/bettertouchtool/assets/apple-music.png"

-- URL-encode a string using Python 3
on urlEncode(theText)
	return do shell script "printf '%s' " & quoted form of theText & " | python3 -c 'import sys, urllib.parse; print(urllib.parse.quote(sys.stdin.read()))'"
end urlEncode

-- Open a Google search in Safari
on googleSearch(searchTerm)
	set encoded to urlEncode(searchTerm)
	tell application "Safari"
		open location "https://www.google.com/search?q=" & encoded
		activate
	end tell
end googleSearch

-- Open a Genius lyrics search in Safari
on lyricsSearch(searchTerm)
	set encoded to urlEncode(searchTerm)
	tell application "Safari"
		open location "https://genius.com/search?q=" & encoded
		activate
	end tell
end lyricsSearch

-- Get now playing info and current player from BetterTouchTool
tell application "BetterTouchTool"
	set songTitle to get_string_variable "BTTNowPlayingInfoTitle"
	set songArtist to get_string_variable "BTTNowPlayingInfoArtist"
	set songAlbum to get_string_variable "BTTNowPlayingInfoAlbum"
	set currentApp to get_string_variable "BTTCurrentlyPlayingApp"
end tell

-- Select icon based on the currently playing app
if currentApp starts with "jellyfin" then
	set appIcon to jellyfinIcon
else if currentApp is "com.apple.Music" then
	set appIcon to appleMusicIcon
else
	set appIcon to finderIcon
end if

-- If nothing is playing, show a brief notification and exit
if songTitle is "" and songArtist is "" then
	do shell script quoted form of alerterPath & " --title " & quoted form of "Media" & " --message " & quoted form of "No content" & " --timeout 5 --app-icon " & quoted form of appIcon
	return
end if

-- Fall back to placeholder values for missing fields
if songTitle is "" then set songTitle to "Unknown Title"
if songArtist is "" then set songArtist to "Unknown Artist"
if songAlbum is "" then set songAlbum to "Unknown Album"

-- Show top-right alert with action buttons and capture response
set alertCmd to quoted form of alerterPath & " --title " & quoted form of songTitle & " --message " & quoted form of (songArtist & " - " & songAlbum) & " --timeout " & notificationTimeout & " --app-icon " & quoted form of appIcon & " --actions Research,Lyrics"

set userChoice to ""
try
	set userChoice to do shell script alertCmd
end try

-- Handle button actions
if userChoice is "Research" then
	googleSearch(songArtist & " " & songTitle & " " & songAlbum)
else if userChoice is "Lyrics" then
	lyricsSearch(songArtist & " " & songTitle)
end if
