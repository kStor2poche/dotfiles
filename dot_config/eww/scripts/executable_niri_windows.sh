#!/bin/bash
# echo "[nothing here]"

function get_windows_info() {
    event_type=$(jq -rc 'keys[0]' <<< "$1")
    # if ! jq -e '.WindowsChanged//.WindowFocusChanged//.WindowOpenedOrChanged' > /dev/null <<< "$1"; then
    #     return
    # fi

    case $event_type in
        "WindowsChanged")
            output=$(jq -rc '.WindowsChanged.windows[] | select(.is_focused == true) | .title' <<< "$1")
            if [[ -z $output ]]; then # if no window (e.g. @niri start)
                return
            fi
            ;;
        "WindowOpenedOrChanged")
            focused=$(jq -rc '.WindowOpenedOrChanged.window.is_focused' <<< "$1")
            if [[ $focused = "false" ]]; then
                return
            fi
            output=$(jq -rc '.WindowOpenedOrChanged.window.title' <<< "$1")
            ;;
        "WindowFocusChanged")
            winid=$(jq -rc '.WindowFocusChanged.id' <<< "$1")
            if [[ $winid = "null" ]]; then
                echo "[nothing here]"
                return
            fi
            output=$(niri msg --json windows | jq -rc ".[] | select(.id == $winid) | .title")
            ;;
        *)
            return
            ;;
    esac

    cut_output="${output%%"\n"*}"

    if [[ $cut_output != "$output" ]];then
        echo "${cut_output}..."
    else
        echo "${output}"
    fi
}

niri msg --json windows | jq -r '.. | (.nodes? // empty)[] | select(.focused==true and .type=="con") | .name'

niri msg --json event-stream | {
    while read -r event; do
        get_windows_info "$event"
    done 
}
