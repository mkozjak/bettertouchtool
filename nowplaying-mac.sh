#!/bin/bash

# Configuration
MEDIA_CONTROL=/opt/homebrew/bin/media-control
TIMEOUT=10
TEMP_IMAGE="/tmp/nowplaying_artwork.jpg"
SENDER="com.apple.finder"

# Function to decode and save artwork
save_artwork() {
    local artwork="$1"
    local output_path="$2"
    if [ -n "$artwork" ] && [ "$artwork" != "null" ]; then
        echo "$artwork" | base64 --decode > "$output_path"
        echo "$output_path"
    else
        echo ""
    fi
}

# Function to perform Google search
google_search() {
    local search_term="$1"
    local encoded_search=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$search_term'''))")
    open -a Safari "https://www.google.com/search?q=$encoded_search"
}

lyrics_search() {
    local search_term="$1"
    local encoded_search=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$search_term'''))")
    open -a Safari "https://genius.com/search?q=$encoded_search"
}

# Check if media-control is available
if [ ! -x "$MEDIA_CONTROL" ]; then
    alerter -title "Media Control Error" -message "media-control not found at $MEDIA_CONTROL" -timeout 5 -sender $SENDER
    exit 1
fi

# Check if jq is available
if ! command -v jq &> /dev/null; then
    alerter -title "Media Control Error" -message "jq is required but not installed. Install with: brew install jq" -timeout 5 -sender $SENDER
    exit 1
fi

# Get song information
output=$("$MEDIA_CONTROL" get 2>/dev/null)

# Check if we got valid JSON output
if [ $? -ne 0 ] || [ -z "$output" ]; then
    alerter -title "Media" -message "No content" -timeout 5 -sender $SENDER
    exit 0
fi

# Check if there's actually media playing
bundle_id=$(echo "$output" | jq -r '.bundleIdentifier // empty')
if [ -z "$bundle_id" ] || [ "$bundle_id" = "null" ]; then
    alerter -title "Media" -message "No content" -timeout 5 -sender $SENDER
    exit 0
fi

# Parse the metadata using jq
title=$(echo "$output" | jq -r '.title // empty' | perl -MHTML::Entities -pe 'decode_entities($_);')
artist=$(echo "$output" | jq -r '.artist // empty' | perl -MHTML::Entities -pe 'decode_entities($_);')
album=$(echo "$output" | jq -r '.album // empty' | perl -MHTML::Entities -pe 'decode_entities($_);')
artwork=$(echo "$output" | jq -r '.artworkData // empty')

# Handle empty fields
if [ -z "$title" ]; then
    title="Unknown Title"
fi

if [ -z "$artist" ]; then
    artist="Unknown Artist"
fi

if [ -z "$album" ]; then
    album="Unknown Album"
fi

# Process artwork and construct message
message="$artist - $album"
imagePath=$(save_artwork "$artwork" "$TEMP_IMAGE")

# Build alerter command
cmd="alerter --title \"$title\" --message \"$message\" --timeout \"$TIMEOUT\" --sender \"$SENDER\" -actions Research,Lyrics"

if [ -n "$imagePath" ] && [ -f "$imagePath" ]; then
    cmd+=" -contentImage \"$imagePath\""
fi

# Execute alerter and handle response
OUTPUT=$(eval "$cmd")

case $OUTPUT in
    "Research")
        search_term="$artist $title $album"
        google_search "$search_term"
        ;;
    "Lyrics")
        search_term="$artist $title"
        lyrics_search "$search_term"
        ;;
esac

# Cleanup
if [ -f "$TEMP_IMAGE" ]; then
    rm "$TEMP_IMAGE"
fi
