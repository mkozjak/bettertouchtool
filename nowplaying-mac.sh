#!/bin/bash

# Configuration
NOWPLAYING_CLI=/opt/homebrew/bin/nowplaying-cli
TIMEOUT=10
TEMP_IMAGE="/tmp/nowplaying_artwork.jpg"
SENDER="com.apple.finder"

# Function to decode and save artwork
save_artwork() {
    local artwork="$1"
    local output_path="$2"
    if [ -n "$artwork" ]; then
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

# Get song information
output=$("$NOWPLAYING_CLI" get title artist album | perl -MHTML::Entities -pe 'decode_entities($_);')
artwork=$("$NOWPLAYING_CLI" get artworkData)

# Parse the metadata
title=$(echo "$output" | sed -n '1p')
artist=$(echo "$output" | sed -n '2p')
album=$(echo "$output" | sed -n '3p')

# Exit if no song is playing
if [ -z "$title" ]; then
    echo "No song currently playing."
    exit 0
fi

# Process artwork and construct message
message="$artist - $album"
imagePath=$(save_artwork "$artwork" "$TEMP_IMAGE")

# Build alerter command
cmd="alerter -title \"$title\" -message \"$message\" -timeout \"$TIMEOUT\" -sender \"$SENDER\" -actions Research,Lyrics"

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
