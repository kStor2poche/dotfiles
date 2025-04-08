#!/bin/bash

function get_workspaces_info() {
    output=$(swaymsg -t get_workspaces | jq -c 'sort_by(.name)')
    # add ' | tonumber' after '.name' if workspace names are numbers
    # echo $output
    # sed 's/[0-9]://g' <<< "$output"
    echo "${output//[0-9]:/}"
}

get_workspaces_info

swaymsg -t subscribe '["workspace"]' --monitor | {
    while read -r event; do
        get_workspaces_info
    done
}
