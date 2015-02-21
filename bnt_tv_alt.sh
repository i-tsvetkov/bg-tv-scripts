#!/bin/bash
pageUrl='http://cdn.bg/live/4eViE8vGzI'
exec rtmpdump\
  --rtmp     'rtmp://edge3.cdn.bg:2020/fls'\
  --app      'fls'\
  --flashVer 'LNX 11,8,800,96'\
  --swfVfy   'http://cdn.bg/eflash/jwplayer510/player.swf'\
  --pageUrl  "$pageUrl"\
  --playpath "bnt.stream?at=$(curl -s "$pageUrl" | grep -oP 'bnt.stream\?at=\K\w+')"\
  --token    'B@1R1st1077'\
  --live --flv - --quiet | mpv --cache=10000\
  --cache-min=10\
  --title='BNT - На живо'\
  --really-quiet --force-window - &
exit

