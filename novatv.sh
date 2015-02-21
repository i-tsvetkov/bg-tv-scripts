#!/bin/bash
exec rtmpdump\
  --rtmp     'rtmp://edge2.cdn.bg:2010/fls'\
  --app      'fls'\
  --flashVer 'LNX 11,8,800,96'\
  --swfVfy   'http://i.cdn.bg/eflash/jwNTV/player-at.swf'\
  --pageUrl  'http://i.cdn.bg/live/0OmMKJ4SgY'\
  --playpath 'ntv_2.stream'\
  --token    'N0v4TV6#2'\
  --live --flv - --quiet | cvlc --file-caching 60000\
  --key-play-pause ''\
  --key-next ''\
  --key-prev ''\
  --quiet - &
exit

