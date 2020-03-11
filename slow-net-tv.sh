#!/bin/bash
set -euo pipefail

# shellcheck source=example.btv.credentials.sh
source ~/.btv.credentials.sh

source functions/bnt.sh
source functions/btv.sh
source functions/nova.sh

killall -q xautolock || true

VOLUME=100

TV_CHANNELS=(
  nova
  btv
  bnt
)

pactl set-sink-mute 0 0
pactl set-sink-volume 0 "${VOLUME}%"

function main() {
  while :
  do
    for tv in "${TV_CHANNELS[@]}"
    do
      case "$tv" in
        nova) nova || true ;;
        btv)  btv  || true ;;
        bnt)  bnt  || true ;;
        *)    exit 1 ;;
      esac

      sleep 1m
    done
  done
}

main
