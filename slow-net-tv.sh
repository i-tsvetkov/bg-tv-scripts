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
  mpv --fs --mute=no --volume=100 --cache=10000\
    --title='NovaTV - На живо'\
    --really-quiet \
    "https://e5-tc.cdn.bg/ntv/fls/ntv_2.stream/chunklist.m3u8?at=4f9fa1f817005def5e368b7b9e896993" &> /dev/null
}

btv()
{
  mpv --fs --mute=no --volume=100 --cache=10000\
    --title='BTV - На живо'\
    --really-quiet \
    "http://46.10.150.112/alpha/alpha/playlist.m3u8" &> /dev/null
}

bnt()
{
  mpv --fs --mute=no --volume=100 --cache=10000\
    --title='BNT - На живо'\
    --really-quiet \
    "https://clb.cdn.bg/bnt1/fls/bnt1.stream/playlist.m3u8?at=4f9fa1f817005def5e368b7b9e896993" &> /dev/null
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
