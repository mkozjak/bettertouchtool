#!/bin/bash

# Configuration
TIMEOUT=10
BLUESOUND_HOST="bluesound.home.arpa:11000"
TEMP_IMAGE="/tmp/nowplaying_artwork.jpg"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ICON="${SCRIPT_DIR}/assets/bluesound.png"
CURL="/usr/bin/curl"
ALERTER="/opt/homebrew/bin/alerter"

# Function to extract XML tag content
extract_tag() {
    local response="$1"
    local tag="$2"
    echo "$response" | sed -n "s/.*<$tag>\(.*\)<\/$tag>.*/\1/p" | perl -MHTML::Entities -pe 'decode_entities($_);'
}

# Function to extract plain text from Bluesound title fields
extract_track_title() {
    local title_field="$1"
    local title

    title=$(echo "$title_field" | sed -n 's/.*title="\([^"]*\)".*/\1/p')
    if [ -n "$title" ]; then
        echo "$title"
        return
    fi

    echo "$title_field" | sed -E 's/^title="//; s/",$//; s/"$//'
}

# Function to download artwork
download_artwork() {
    local url="$1"
    local output_path="$2"

    # Download to temporary file first
    local temp_file="/tmp/artwork_temp"
    $CURL -s "$url" --output "$temp_file"

    # Check file type
    local file_type=$(file -b "$temp_file")

    if [[ $file_type == *"image"* ]] || [[ $file_type == *"PNG"* ]] || [[ $file_type == *"JPEG"* ]]; then
        mv "$temp_file" "$output_path"
        return 0
    elif [[ $file_type == *"ASCII text"* ]] || [[ $file_type == *"UTF-8 text"* ]]; then
        # Read URL from text file and download actual image
        local image_url=$(cat "$temp_file")
        $CURL -s "$image_url" --output "$output_path"
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
response=$($CURL -s "http://${BLUESOUND_HOST}/Status")

# Extract metadata
album=$(extract_tag "$response" "album")
artist=$(extract_tag "$response" "artist")
title1=$(extract_tag "$response" "title1")
title2=$(extract_tag "$response" "title2")
title3=$(extract_tag "$response" "title3")
title_field="$title1"
title=$(extract_track_title "$title_field")
image_path=$(extract_tag "$response" "image")
stream_url=$(extract_tag "$response" "streamUrl")
service=$(extract_tag "$response" "service")
service_name=$(extract_tag "$response" "serviceName")
service_type=$(extract_tag "$response" "serviceType")
state=$(extract_tag "$response" "state")

if [ -z "$artist" ]; then
    artist=$(echo "$title_field" | sed -n 's/.*artist="\([^"]*\)".*/\1/p')
fi

if [ -z "$album" ]; then
    album=$(echo "$title_field" | sed -n 's/.*album="\([^"]*\)".*/\1/p')
fi

is_radio=false
if [ "$service" = "TuneIn" ] && [ "$service_type" = "RadioService" ]; then
    is_radio=true
fi

if [ "$is_radio" = true ]; then
    title="$title1"
    radio_artist=""
    radio_track=""
    if [ -n "$title2" ]; then
        radio_artist=$(echo "$title2" | sed -E 's/ - .*//')
        radio_track=$(echo "$title2" | sed -E 's/^.* - //')
        # Capitalize artist and track (first letter upper, rest lower, Unicode-aware)
        radio_artist=$(echo "$radio_artist" | perl -CS -pe 's/(\S+)/\u\L$1/g')
        radio_track=$(echo "$radio_track" | perl -CS -pe 's/(\S+)/\u\L$1/g')
    fi

    if [ -n "$radio_artist" ]; then
        artist="$radio_artist"
    fi
    if [ -n "$radio_track" ]; then
        title="$title1"
        message="$radio_artist - $radio_track"
    else
        message="$title1"
    fi
fi

if [ -z "$album" ]; then
    album=$(echo "$title_field" | sed -n 's/.*album="\([^"]*\)".*/\1/p')
fi

# Exit if no stream or track is playing
if [ -z "$title" ] || [ "$state" == "stop" ]; then
    if [ "$is_radio" = true ] && [ -n "$title1" ]; then
        title="$title1"
        if [ -z "$message" ]; then
            message="${artist:-Unknown Artist} - ${title2:-Unknown Track}"
        fi
    elif [ -n "$service_name" ] || [ -n "$stream_url" ]; then
        title="${service_name:-Bluesound}"
        message="${artist:-Unknown Artist} - ${album:-${stream_url:-Unknown Stream}}"
    else
        $ALERTER --title "Bluesound" --message "Playback stopped" --timeout 5 --app-icon $ICON
        exit 0
    fi
fi

# Download artwork
image_url="http://${BLUESOUND_HOST}${image_path}"
download_artwork "$image_url" "$TEMP_IMAGE"

# Construct notification message
if [ -z "$message" ]; then
    message="$artist - $album"
fi

# Build $ALERTER command
cmd="$ALERTER --title \"$title\" --message \"$message\" --timeout \"$TIMEOUT\" --app-icon \"$ICON\" --actions Research,Lyrics"
echo $cmd
if [ -f "$TEMP_IMAGE" ]; then
    cmd+=" --content-image \"$TEMP_IMAGE\""
fi

# Execute $ALERTER and capture output
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
