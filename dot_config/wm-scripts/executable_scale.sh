#!/bin/bash

scaleval=$(swaymsg -t get_outputs | jq -rc '.[] | select(.name | contains("eDP-1")) .scale')

if [[ $scaleval == "1.0" ]]; then
    swaymsg output eDP-1 scale 1.5
else
    swaymsg output eDP-1 scale 1
fi
