#!/usr/bin/env bash
set -euox pipefail

METAMOD_VERSION=1145
SOURCEMOD_VERSION=6528
SERVER_DIR="/data"
STEAMCMDDIR="/steamcmd"
GAME_PORT=27016

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
update
ls /data
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

/data/srcds_run -port "${GAME_PORT}" -game "sfclassic" +clientport 27005 +tv_port 27060 ${GAME_ARGS}
