#!/bin/sh

scripts_dir="$HOME/.config/scripts/"
options=$(ls -1 $scripts_dir)
choice=$(echo -e $options | sed 's/\s/\n/g' | wofi --dmenu)

if [[ $choice ]]
then
    $scripts_dir$choice
fi


