#!/bin/bash

echo "Starting CS2 server installation"

# fix for cs
eval bash "${STEAM_CMD_DIR}/steamcmd.sh" +force_install_dir "${STEAM_CS_DIR}" \
  +login anonymous \
  +app_update 730 validate \
  +quit

# steamclient.so fix
mkdir -p "${STEAM_HOME}/.steam/sdk64"
ln -sfT ${STEAM_CMD_DIR}/linux64/steamclient.so "${STEAM_HOME}/.steam/sdk64/steamclient.so"

echo "Starting server with token: ${STEAM_TOKEN}"

eval "${STEAM_CS_DIR}/game/bin/linuxsteamrt64/cs2" \
  -dedicated \
  +map "de_dust2" \
  +sv_setsteamaccount "${STEAM_TOKEN}"
