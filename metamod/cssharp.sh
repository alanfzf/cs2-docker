#!/bin/bash

# CS2 constants
CS_PATH="/home/steam/cs2-dedicated/game/csgo"

# CS-Sharp Constants
API_URL="https://api.github.com/repos/roflmuffin/CounterStrikeSharp/releases/latest"
# Get the latest release data from the GitHub API
RELEASE_DATA=$(curl -s $API_URL)
# Extract the download URL for the file using grep, sed, and awk
CS_SHARP_DL_URL=$(echo "$RELEASE_DATA" | grep -oP '"browser_download_url": "\K(.*?counterstrikesharp-with-runtime-build.*\.zip)' | head -n 1)

if [ -z "$CS_SHARP_DL_URL" ]; then
  echo "could not retrieve the latest version of cs-sharp..."
  exit 1
fi

# Download the file
echo "downloading cs-sharp... $CS_SHARP_DL_URL"
curl -sqLo cssharp.zip $CS_SHARP_DL_URL
unzip cssharp.zip
rm cssharp.zip
mv addons $CS_PATH
