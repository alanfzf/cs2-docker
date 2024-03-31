#!/bin/bash

echo "Starting CS2 server installation"

mkdir -p "${STEAM_CS_DIR}" || true

# steamclient.so fix
eval bash "${STEAM_CMD_DIR}/steamcmd.sh" +quit

mkdir -p "${STEAM_HOME}/.steam/sdk64"
mkdir -p "${STEAM_HOME}/.steam/sdk32"

ln -sfT ${STEAM_CMD_DIR}/linux64/steamclient.so "${STEAM_HOME}/.steam/sdk64/steamclient.so"
ln -sfT ${STEAM_CMD_DIR}/linux32/steamclient.so "${STEAM_HOME}/.steam/sdk32/steamclient.so"

# download cs
eval bash "${STEAM_CMD_DIR}/steamcmd.sh" +force_install_dir "${STEAM_CS_DIR}" \
  +login anonymous \
  +app_update 730 validate \
  +quit

echo "Starting server with token: ${STEAM_TOKEN}"

eval "${STEAM_CS_DIR}/game/bin/linuxsteamrt64/cs2" \
  -dedicated \
  +map "de_dust2" \
  +sv_setsteamaccount "${STEAM_TOKEN}"
