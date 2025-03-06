#!/bin/bash

# Configuration
TIMEOUT=10
BLUESOUND_HOST="bluesound.local:11000"
TEMP_IMAGE="/tmp/nowplaying_artwork.jpg"
SENDER="com.bluesound.bluos"

# Function to extract XML tag content
extract_tag() {
    local response="$1"
    local tag="$2"
    echo "$response" | sed -n "s/.*<$tag>\(.*\)<\/$tag>.*/\1/p" | perl -MHTML::Entities -pe 'decode_entities($_);'
}

# Function to download artwork
download_artwork() {
    local url="$1"
    local output_path="$2"

    # Download to temporary file first
    local temp_file="/tmp/artwork_temp"
    curl -s "$url" --output "$temp_file"

    # Check file type
    local file_type=$(file -b "$temp_file")

    if [[ $file_type == *"image"* ]] || [[ $file_type == *"PNG"* ]] || [[ $file_type == *"JPEG"* ]]; then
        mv "$temp_file" "$output_path"
        return 0
    elif [[ $file_type == *"ASCII text"* ]] || [[ $file_type == *"UTF-8 text"* ]]; then
        # Read URL from text file and download actual image
        local image_url=$(cat "$temp_file")
        curl -s "$image_url" --output "$output_path"
        rm "$temp_file"
        return 0
    fi

    # Cleanup if neither condition met
    rm "$temp_file"
    return 1
}

# Function to perform Google search
web_search() {
    local search_term="$1"
    local service="$2"
    local encoded_search=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$search_term'''))")

    case $service in
        "google")
            open -a Safari "https://www.google.com/search?q=$encoded_search"
            ;;
        "lyrics")
            open -a Safari "https://genius.com/search?q=$encoded_search"
            ;;
    esac
}

# Fetch the status from the Bluesound endpoint
response=$(curl -s "http://${BLUESOUND_HOST}/Status")

# Extract metadata
album=$(extract_tag "$response" "album")
artist=$(extract_tag "$response" "artist")
title=$(extract_tag "$response" "title1")
image_path=$(extract_tag "$response" "image")

# Exit if no song is playing
if [ -z "$title" ]; then
    alerter -title "Bluesound" -message "Playback stopped" -timeout 5 -sender $SENDER
    exit 0
fi

# Download artwork
image_url="http://${BLUESOUND_HOST}${image_path}"
download_artwork "$image_url" "$TEMP_IMAGE"

# Construct notification message
message="$artist - $album"

# Build alerter command
cmd="alerter -title \"$title\" -message \"$message\" -timeout \"$TIMEOUT\" -sender \"$SENDER\" -actions Research,Lyrics"

if [ -f "$TEMP_IMAGE" ]; then
    cmd+=" -contentImage \"$TEMP_IMAGE\""
fi

# Execute alerter and capture output
OUTPUT=$(eval "$cmd")

# Handle button clicks
case $OUTPUT in
    "Research")
        search_term="$artist $title $album"
        web_search "$search_term" "google"
        ;;
    "Lyrics")
        search_term="$artist $title"
        web_search "$search_term" "lyrics"
        ;;
esac

# Cleanup
if [ -f "$TEMP_IMAGE" ]; then
    rm "$TEMP_IMAGE"
fi
