#!/bin/bash
set -euo pipefail

function btv() {
  cookiejar="$(mktemp '/tmp/tmp.btv.cookiejar.XXXXXXXXXX')"

  curl 'https://btvplus.bg/lbin/social/login.php' \
    --fail \
    --silent \
    -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:73.0) Gecko/20100101 Firefox/73.0' \
    -H 'Accept: application/json, text/javascript, */*; q=0.01' \
    -H 'Accept-Language: en-US,en;q=0.5' \
    -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
    -H 'X-Requested-With: XMLHttpRequest' \
    -H 'Origin: https://btvplus.bg' \
    -H 'DNT: 1' \
    -H 'Connection: keep-alive' \
    -H 'Referer: https://btvplus.bg/live/' \
    -H 'Pragma: no-cache' \
    -H 'Cache-Control: no-cache' \
    --compressed \
    --data "username=${BTV_USERNAME}&password=${BTV_PASSWORD}" \
    --cookie-jar "$cookiejar" &> /dev/null

  timestamp_in_milliseconds="$(date '+%s%3N')"

  url="$(
    curl "https://btvplus.bg/lbin/v3/btvplus/player_config.php?media_id=2110383625&_=${timestamp_in_milliseconds}" \
      --fail \
      --silent \
      -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:73.0) Gecko/20100101 Firefox/73.0' \
      -H 'Accept: application/json, text/javascript, */*; q=0.01' \
      -H 'Accept-Language: en-US,en;q=0.5' \
      -H 'X-Requested-With: XMLHttpRequest' \
      -H 'DNT: 1' \
      -H 'Connection: keep-alive' \
      -H 'Referer: https://btvplus.bg/live/' \
      -H 'Pragma: no-cache' \
      -H 'Cache-Control: no-cache' \
      --compressed \
      --cookie "$cookiejar" | jq . | grep --perl-regexp --only-matching '[^"]+playlist.m3u8[^"\\]+'
  )"

  rm "$cookiejar"

  mpv --fullscreen \
    --mute=no \
    --volume=100 \
    --cache=10000 \
    --title='BTV - На живо' \
    --really-quiet \
    "$url" &> /dev/null
}
