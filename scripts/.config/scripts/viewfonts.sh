#!/bin/sh

fonts=$(fc-list |sed "s/:.*//" | awk "{print $1}")
choice=$(echo "$fonts" | wofi --dmenu)
echo $choice

display "$choice" -label "hello world"


