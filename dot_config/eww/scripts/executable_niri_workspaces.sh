#!/bin/bash

function get_workspaces_info() {
    output=$(niri msg --json workspaces | jq -c 'sort_by(.idx)')
    # add ' | tonumber' after '.name' if workspace names are numbers
    # echo $output
    # sed 's/[0-9]://g' <<< "$output"
    echo "${output//[0-9]:/}"
}

get_workspaces_info

niri msg --json event-stream | {
    while read -r event; do
        if echo -ne "$event" | jq -e '.WorkspacesChanged//.WorkspaceActivated' > /dev/null; then
            get_workspaces_info
        fi
    done
}
