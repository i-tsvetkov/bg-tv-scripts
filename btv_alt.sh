#!/bin/bash
exec rtmpdump\
  --rtmp     'rtmp://46.10.150.113:80/ios'\
  --app      'ios'\
  --flashVer 'LNX 11,8,800,96'\
  --swfVfy   'http://images.btv.bg/fplayer/flowplayer.commercial-3.2.5.swf'\
  --pageUrl  'http://www.btv.bg/live/'\
  --playpath 'btvbglive'\
  --live --flv - --quiet | mpv --cache=10000\
  --cache-min=10\
  --title='BTV - На живо'\
  --really-quiet - &
exit

