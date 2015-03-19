#!/bin/bash
pageUrl='http://cdn.bg/live/4eViE8vGzI'
exec rtmpdump\
  --rtmp     'rtmp://edge11.cdn.bg:2020/fls'\
  --app      'fls'\
  --flashVer 'LNX 11,8,800,96'\
  --swfVfy   'http://cdn.bg/eflash/jwplayer510/player.swf'\
  --pageUrl  "$pageUrl"\
  --playpath "bnt.stream?at=$(curl -s -H 'Referer: http://tv.bnt.bg/bnt1/16x9/' "$pageUrl" | grep -oP 'bnt.stream\?at=\K\w+')"\
  --token    'B@1R1st1077'\
  --live --flv - --quiet | cvlc --file-caching 60000\
  --key-play-pause ''\
  --key-next ''\
  --key-prev ''\
  --quiet - &
exit

