#!/bin/bash

update_bar() {
    if [[ $XDG_CURRENT_DESKTOP = "sway" ]]; then
        screens="$(swaymsg -t get_outputs | jq -rc '.[].name')"
    elif [[ $XDG_CURRENT_DESKTOP = "niri" ]]; then
        screens="$(niri msg --json outputs | jq -rc '.[].name')"
    else
        echo "No suitable wm found :/"
        notify-send "bar.sh" "No suitable wm found :/" -i error -c urgent -a "bar.sh"
        exit 1
    fi
    eww close-all
    # shellcheck disable=SC2046
    eww open-many $(for s in $screens; do echo -n "statusbar:$s" --arg "$s:screen=$s "; done)
}

update_bar

if [[ $XDG_CURRENT_DESKTOP = "sway" ]]; then
    swaymsg -t subscribe '["output"]' --monitor | {
        while read -r _event; do
            update_bar
        done
    }
fi


if [[ $XDG_CURRENT_DESKTOP = "niri" ]]; then
    screens="$(niri msg --json outputs | jq -rc '.[].name')"
    niri msg --json event-stream | {
        while read -r event; do
            event_type=$(jq -rc 'keys[0]' <<< "$event")
            if [[ $event_type == "WorkspacesChanged" ]]; then
                nu_screens="$(niri msg --json outputs | jq -rc '.[].name')"
                # shellcheck disable=SC2086,SC2048
                if [[ ! "$(printf "%s\n" ${screens[*]}|sort)" == "$(printf "%s\n" ${nu_screens[*]}|sort)" ]]; then
                    screens=$nu_screens
                    update_bar 
                fi
            fi
        done 
    }
fi
