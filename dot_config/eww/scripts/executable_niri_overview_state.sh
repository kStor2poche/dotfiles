#!/bin/bash
niri msg --json overview-state | jq -c '.is_open'

niri msg --json event-stream | {
    while read -r event; do
        if val=$(echo -ne "$event" | jq -e '.OverviewOpenedOrClosed'); then
            jq -c '.is_open' <<< $val
        fi
    done
}
