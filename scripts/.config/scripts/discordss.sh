#!/bin/sh


devices=$(v4l2-ctl --list-devices | grep /dev | wc -l)

if [[ $devices == 1 ]]
then
sudo modprobe v4l2loopback exclusive_caps=1 card_label=VirtualVideoDevice
fi
# TODO: Add ability to wf-record a region (slurp)
# possibly add wofi integration
# wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video1 -x yuv420p
# unset SDL_VIDEODRIVER
# wf-recorder -c rawvideo -m sdl -f pipe:wayland-mirror
# SDL_VIDEODRIVER=x11 
wf-recorder -c rawvideo -m sdl -f pipe:xwayland-mirror
