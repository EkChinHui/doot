#!/bin/sh

up_icon="~/.config/dunst/icons/audio-volume-high-symbolic.svg"
down_icon="~/.config/dunst/icons/audio-volume-muted-symbolic.svg"
echo $1
if [[ "$1" == "up" ]]
then
    echo up
    volume=$(pactl get-sink-volume 0 | awk '{print $5}' | sed 's/%//')
    dunstify Volume --hints=int:value:$volume -i $up_icon -r 1510
else
    echo down
    volume=$(pactl get-sink-volume 0 | awk '{print $5}' | sed 's/%//')
    dunstify Volume --hints=int:value:$volume -i $down_icon -r 1510
fi
