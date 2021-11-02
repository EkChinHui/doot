#!/bin/sh


devices=$(v4l2-ctl --list-devices | grep /dev | wc -l)

if [[ $devices == 1 ]]
then
sudo modprobe v4l2loopback exclusive_caps=1 card_label=VirtualVideoDevice
fi
# TODO: Add ability to wf-record a region (slurp)
# possibly add wofi integration
wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video1 -x yuv420p

env -u WAYLAND_DISPLAY mpv av://v4l2:/dev/video1

export XDG_CURRENT_DESKTOP=gnome


