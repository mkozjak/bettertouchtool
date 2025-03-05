#!/bin/bash

np=/opt/homebrew/bin/nowplaying-cli

# Get song info from nowplaying-cli
output=$("$np" get title artist album | perl -MHTML::Entities -pe 'decode_entities($_);')
artwork=$("$np" get artworkData)

# Parse the lines into variables
title=$(echo "$output" | sed -n '1p')
artist=$(echo "$output" | sed -n '2p')
album=$(echo "$output" | sed -n '3p')

# Print information (for debugging purposes)
# echo "Album: $album"
# echo "Artist: $artist"
# echo "Title: $title"

# Check if title is empty (no song playing)
if [ -z "$title" ]; then
  echo "No song currently playing."
  exit 0
fi

# Construct message
message="$artist - $album"

# Decode base64 artwork and save to temporary file
if [ -n "$artwork" ]; then
  echo "$artwork" | base64 --decode > /tmp/nowplaying_artwork.jpg
  imagePath="/tmp/nowplaying_artwork.jpg"
else
  imagePath=""
fi

# Send notification with alerter
if [ -n "$imagePath" ]; then
    alerter -title "$title" -message "$message" -timeout 5 -sender com.apple.finder -contentImage "$imagePath"
else
    alerter -title "$title" -message "$message" -timeout 5 -sender com.apple.finder
fi
