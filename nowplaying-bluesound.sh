#!/bin/bash

# Fetch the status from the Bluesound endpoint
response=$(curl -s "http://bluesound.local:11000/Status")

# Extract relevant information using grep and sed/awk
album=$(echo "$response" | sed -n 's/.*<album>\(.*\)<\/album>.*/\1/p')
artist=$(echo "$response" | sed -n 's/.*<artist>\(.*\)<\/artist>.*/\1/p')
title=$(echo "$response" | sed -n 's/.*<title1>\(.*\)<\/title1>.*/\1/p')
image_path=$(echo "$response" | sed -n 's/.*<image>\(.*\)<\/image>.*/\1/p')

# Decode URL components in the image path (if necessary)
image_url="http://bluesound.local:11000$image_path"

# Print information (for debugging purposes)
echo "Album: $album"
echo "Artist: $artist"
echo "Title: $title"
echo "Image URL: $image_url"

imagePath="/tmp/nowplaying_artwork.jpg"

# Download the album artwork
curl -s "$image_url" --output "$imagePath"

# Construct message
message="$artist - $album"

# Send notification with alerter
if [ -n "$imagePath" ]; then
    alerter -title "$title" -message "$message" -timeout 5 -sender com.bluesound.bluos -contentImage "$imagePath"
else
    alerter -title "$title" -message "$message" -timeout 5 -sender com.bluesound.bluos
fi
