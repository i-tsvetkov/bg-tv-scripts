#!/bin/bash

killall -q xautolock

TV=nova
VOLUME=300

TV_CHANNELS=(nova btv bnt)

OPTS=`getopt -a -l "tv:,volume:,vol:" -o "v:t:" -- "$@"`
eval set -- "$OPTS"

while true; do
  case $1 in
    --tv|-t)
      TV=$2 ;
      shift 2
      ;;
    -v|--vol|--volume)
      VOLUME=$2 ;
      shift 2
      ;;
    --)
        shift ; break
      ;;
    *)
      exit `false`
      ;;
  esac
done

pactl set-sink-mute 0 0
pactl set-sink-volume 0 $VOLUME%

nova()
{
  url=$(curl -s 'https://i.cdn.bg/live/0OmMKJ4SgY' -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: bg-BG,bg;q=0.9,en;q=0.8,it;q=0.7,uk;q=0.6,mg;q=0.5,ru;q=0.4,de;q=0.3,id;q=0.2' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: https://nova.bg/live' -H 'Connection: keep-alive' -H 'Cache-Control: no-cache' --compressed | grep -F 'playlist.m3u8?at=' | cut -d\' -f2)
  mpv --fs --mute=no --volume=100 --cache=10000\
    --title='NovaTV - На живо'\
    --really-quiet \
    "$url" &> /dev/null
}

btv()
{
  mpv --fs --mute=no --volume=100 --cache=10000\
    --title='BTV - На живо'\
    --really-quiet \
    "http://46.10.150.114/alpha/alpha/playlist.m3u8" &> /dev/null
}

bnt()
{
  url=$(curl -s 'http://cdn.bg/live/4eViE8vGzI' -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: bg-BG,bg;q=0.9,en;q=0.8,it;q=0.7,uk;q=0.6,mg;q=0.5,ru;q=0.4,de;q=0.3,id;q=0.2' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: http://tv.bnt.bg/bnt1/16x9/' -H 'Connection: keep-alive' -H 'Cache-Control: no-cache' --compressed | grep -F 'playlist.m3u8?at=' | cut -d\' -f2)
  mpv --fs --mute=no --volume=100 --cache=10000\
    --title='BNT - На живо'\
    --really-quiet \
    "$url" &> /dev/null
}

go_tv()
{
  while :
  do
    for tv in "${TV_CHANNELS[@]}"
    do
      case "$tv" in
        nova) nova ;;
        btv)  btv ;;
        bnt)  bnt ;;
        *)    exit `false` ;;
      esac

      sleep 1m

      if [ $? -eq 0 ]; then
        continue
      else
        return
      fi
    done
  done
}

wait_tv()
{
  for i in {1..60}
  do
    expr $i \* 10 / 6
    sleep 1
  done | zenity --progress --auto-close &> /dev/null
}

log()
{
  echo -e "`date`:\t$1" >> /tmp/tv.log
}

main()
{
  lockfile-check .tv
  [[ $? -ne 0 ]] && lockfile-create .tv
  while :
  do
    go_tv
    log "($?) The video stream stopped!" &
    ping -c4 8.8.8.8 &> /dev/null && log 'Net up.' || log 'Net down!' &
    wait_tv
    if [ $? -ne 0 ]; then
      lockfile-remove .tv
      exit
    fi
  done
}

main
