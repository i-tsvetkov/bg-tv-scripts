#!/bin/bash
set -euo pipefail

function bnt() {
  url="$(
    curl 'http://cdn.bg/live/4eViE8vGzI' \
      --fail \
      --silent \
      -H 'Pragma: no-cache' \
      -H 'Accept-Encoding: gzip, deflate' \
      -H 'Accept-Language: bg-BG,bg;q=0.9,en;q=0.8,it;q=0.7,uk;q=0.6,mg;q=0.5,ru;q=0.4,de;q=0.3,id;q=0.2' \
      -H 'Upgrade-Insecure-Requests: 1' \
      -H 'User-Agent: Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36' \
      -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' \
      -H 'Referer: http://tv.bnt.bg/bnt1/16x9/' \
      -H 'Connection: keep-alive' \
      -H 'Cache-Control: no-cache' \
      --compressed | grep --fixed-strings 'playlist.m3u8?at=' | cut --delimiter \' --fields 2
  )"

  mpv --fullscreen \
    --mute=no \
    --volume=100 \
    --cache=10000 \
    --title='BNT - На живо' \
    --really-quiet \
    "$url" &> /dev/null
}
