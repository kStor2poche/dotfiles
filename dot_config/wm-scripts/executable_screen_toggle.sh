#!/bin/bash

# TODO: changer l'offset automatiquement selon la résolution de l'output en question ?
monitor=$1
swaymsg output "$monitor" toggle
dunstify -a 'display_enabled_notif' -u normal -t 2250 -r 420 -i /usr/share/icons/breeze-dark/devices/22/monitor.svg 'Monitor state toggled' "$monitor $(disabled=$(swaymsg -t get_outputs | grep -A 1 HDMI-A-1 | grep '"active": false');if [[ -z $disabled ]];then echo -n on;swaymsg output DP-1 pos 1680 0 > /dev/null;else echo -n off;swaymsg output DP-1 pos 0 0 > /dev/null;fi)"
