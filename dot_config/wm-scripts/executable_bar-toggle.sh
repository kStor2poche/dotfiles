#!/bin/bash

scriptdir=$(dirname "$0")
# kinda cheap since other widgets might have state but eh
state=$(eww state)

if [[ -z $state ]]; then
    if [[ $XDG_CURRENT_DESKTOP = sway ]]; then
        swaymsg gaps inner all set 10
    fi
    "${scriptdir}/bar.sh"
else
    if [[ $XDG_CURRENT_DESKTOP = sway ]]; then
        swaymsg gaps inner all set 0
    fi
    eww close-all
fi
