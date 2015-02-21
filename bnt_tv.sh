#!/bin/bash
exec rtmpdump\
  --rtmp     'rtmp://edge3.cdn.bg:2020/fls'\
  --app      'fls'\
  --flashVer 'LNX 11,8,800,96'\
  --swfVfy   'http://cdn.bg/eflash/jwplayer510/player.swf'\
  --pageUrl  'http://cdn.bg/live/4eViE8vGzI'\
  --playpath 'bnt.stream?at=2c2e68beb8a99e014f8e12e785107b05'\
  --token    'B@1R1st1077'\
  --live --flv - --quiet | cvlc --file-caching 60000\
  --key-play-pause ''\
  --key-next ''\
  --key-prev ''\
  --quiet - &
exit

