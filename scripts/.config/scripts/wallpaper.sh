#!/bin/sh

wallpapers=$(find ~/.config/wallpapers/)
echo $wallpapers
choice=$(echo "$wallpapers" | wofi --dmenu)

killall -9 swaybg

swaybg -i $choice -m fill
