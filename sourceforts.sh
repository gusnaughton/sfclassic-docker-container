#!/usr/bin/env bash
set -euox pipefail

GAME_DIR="/data"
METAMOD_VERSION=1145
SOURCEMOD_VERSION=6528
STEAMCMDDIR="/steamcmd"

function update() {
   "${STEAMCMDDIR}/steamcmd.sh" \
    +force_install_dir "${GAME_DIR}" \
    +@sSteamCmdForcePlatformType windows \
    +login anonymous \
    +app_update 205 \
    +app_update 215 \
    +quit
}

if [ ! -f "${GAME_DIR}/.installed" ]; then
  update
  touch "${GAME_DIR}/.installed"
else
  echo "Already installed."
fi

"${GAME_DIR}/bin/srcds_run.sh" -port "${GAME_PORT}" -clientport "${CLIENT_PORT}" -game "${GAME_DIR}/sourceforts" ${GAME_ARGS}
