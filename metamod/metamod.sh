#!/bin/bash
set -eo pipefail

# CS2 constants
CS_PATH="/home/steam/cs2-dedicated/game/csgo"

# METAMOD constants
METAMOD_PAGE=$(curl -s "https://www.metamodsource.net/downloads.php/?branch=master")
METAMOD_DL_URL=$(echo "$METAMOD_PAGE" | grep -oP "https://mms\.alliedmods\.net/mmsdrop/[^/]+/[^/]+-linux\.tar\.gz"| head -n 1)

if [[ -z "$METAMOD_DL_URL" ]]; then
    echo "could not find the metamod download for linux"
    exit 1
fi

echo "downloading metamod... $METAMOD_DL_URL"
curl -sqL $METAMOD_DL_URL | tar xvfz -

# copy addons to cs2 path
mv addons $CS_PATH

# add metamod to gameinfo.gi
sed -i '/Game_LowViolence\s\+csgo_lv/a\ Game  csgo/addons/metamod' "$CS_PATH/gameinfo.gi"
