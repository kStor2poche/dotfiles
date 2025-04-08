#!/bin/bash
echo "[nothing here]"

function get_windows_info() {
    event=$1
    focused=$(jq -M -r --unbuffered '.container | .focused' <<< "$event")
    if [[ $focused == "false" ]]; then
        return
    fi
    change=$(jq -M -r --unbuffered '.change' <<< "$event")
    if [[ $change == "close" ]]; then
        echo "[nothing here]"
        return
    fi
    output=$(jq -M -r --unbuffered '.container | .name' <<< "$event")
    cut_output="${output%%"\n"*}"

    if [[ $cut_output != "$output" ]];then
        echo "${cut_output}..."
    else
        echo "${output}"
    fi
    echo "$output"
}

swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select(.focused==true and .type=="con") | .name'

swaymsg -t subscribe '["window"]' --monitor --raw | {
    while read -r event; do
        get_windows_info "$event"
    done
}
