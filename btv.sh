#!/bin/bash
exec rtmpdump\
  --rtmp     'rtmp://hls.btv.bg.sof.cmestatic.com:80/alpha'\
  --app      'alpha'\
  --flashVer 'LNX 11,8,800,96'\
  --swfVfy   'http://www.btv.bg/static/bg/shared/app/flowplayer/flowp.layer.commercial-3.2.18.swf'\
  --pageUrl  'http://www.btv.bg/live/'\
  --playpath 'alpha'\
  --live --flv - --quiet | cvlc --file-caching 60000\
  --key-play-pause ''\
  --key-next ''\
  --key-prev ''\
  --quiet - &
exit

