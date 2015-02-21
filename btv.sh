#!/bin/bash
exec rtmpdump\
  --rtmp     'rtmp://46.10.150.113:80/ios'\
  --app      'ios'\
  --flashVer 'LNX 11,8,800,96'\
  --swfVfy   'http://images.btv.bg/fplayer/flowplayer.commercial-3.2.5.swf'\
  --pageUrl  'http://www.btv.bg/live/'\
  --playpath 'btvbglive'\
  --live --flv - --quiet | cvlc --file-caching 60000\
  --key-play-pause ''\
  --key-next ''\
  --key-prev ''\
  --quiet - &
exit

