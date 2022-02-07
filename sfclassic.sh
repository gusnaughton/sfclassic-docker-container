#!/usr/bin/env bash
set -euox pipefail

METAMOD_VERSION=1145
SOURCEMOD_VERSION=6528
SERVER_DIR="/data"
STEAMCMDDIR="/steamcmd"
GAME_PORT=27016
GAME_DIR="/data/sfclassic"
function update() {
  "${STEAMCMDDIR}/steamcmd.sh" \
    +force_install_dir "${SERVER_DIR}" \
    +login anonymous \
    +app_update 244310 \
    +quit
  wget http://linuxgsm.download/SourceFortsClassic/SFClassic-1.0-RC7-fix.tar.xz -O /data/SFC.tar.xz
  ls /data
  tar xvf /data/SFC.tar.xz -C /data/
}
if [ ! -f "${GAME_DIR}/.installed" ]; then
  update
  ln -s "${SERVER_DIR}/bin/datacache_srv.so" "${SERVER_DIR}/bin/datacache.so"
  ln -s "${SERVER_DIR}/bin/dedicated_srv.so" "${SERVER_DIR}/bin/dedicated.so"
  ln -s "${SERVER_DIR}/bin/engine_srv.so" "${SERVER_DIR}/bin/engine.so"
  ln -s "${SERVER_DIR}/bin/materialsystem_srv.so" "${SERVER_DIR}/bin/materialsystem.so"
  ln -s "${SERVER_DIR}/bin/replay_srv.so" "${SERVER_DIR}/bin/replay.so"
  ln -s "${SERVER_DIR}/bin/shaderapiempty_srv.so" "${SERVER_DIR}/bin/shaderapiempty.so"
  ln -s "${SERVER_DIR}/bin/soundemittersystem_srv.so" "${SERVER_DIR}/bin/soundemittersystem.so"
  ln -s "${SERVER_DIR}/bin/studiorender_srv.so" "${SERVER_DIR}/bin/studiorender.so"
  ln -s "${SERVER_DIR}/bin/vphysics_srv.so" "${SERVER_DIR}/bin/vphysics.so"
  ln -s "${SERVER_DIR}/bin/scenefilecache_srv.so" "${SERVER_DIR}/bin/scenefilecache.so"
  wget -qO- "https://mms.alliedmods.net/mmsdrop/1.11/mmsource-1.11.0-git${METAMOD_VERSION}-linux.tar.gz" | tar xvzf - -C "${GAME_DIR}" &&
    rm "${GAME_DIR}/addons/metamod_x64.vdf"
  # Install Sourcemod (comment out for tournament servers)
  wget -qO- "https://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git${SOURCEMOD_VERSION}-linux.tar.gz" | tar xvzf - -C "${GAME_DIR}"
  touch "${GAME_DIR}/.installed"
else
  echo "Already installed."
fi

/data/srcds_run -port "${GAME_PORT}" -game "sfclassic" ${GAME_ARGS}
