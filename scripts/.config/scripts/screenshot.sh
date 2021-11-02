#!/bin/sh

options="whole screen\ncurrent window\npart of screen"
save_folder="$HOME/Pictures/screenshots/"

choice=$(echo -e $options | wofi --height 75 --dmenu)

copy=$(echo -e "save\nclipboard" | wofi --height 50 --dmenu)
if [[ $copy == 'save' ]]
then
    file_name=$(echo "Save as ___?" | wofi --height 1 --dmenu)
    save_file=$save_folder$file_name
fi

if [[ $choice == "whole screen" ]]
then
    if [[ $copy == 'save' ]]
    then
        grim $save_file
	    # grim $save_folder$file_name
    elif [[ $copy == 'clipboard' ]]
    then
	    grim - | wl-copy
    fi
elif [[ $choice == "current window" ]]
then
    if [[ $copy == 'save' ]]
    then
        grim -g "$(swaymsg -t get_tree | \
            jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" $save_file
    elif [[ $copy == 'clipboard' ]]
    then
        grim -g "$(swaymsg -t get_tree | \
            jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" - | wl-copy
    fi
elif [[ $choice == "part of screen" ]]
then
    if [[ $copy == 'save' ]]
    then
        grim -g "$(slurp)" $save_file
    elif [[ $copy == 'clipboard' ]]
    then
        grim -g "$(slurp)" - | wl-copy
    fi
fi
