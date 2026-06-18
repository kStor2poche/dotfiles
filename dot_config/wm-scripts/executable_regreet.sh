#!/bin/bash
regreet & p=$!
# wait for regreet window to actually appear and get focus
swaymsg -t subscribe '["window"]'
get_focused() {
    swaymsg -t get_tree | jq -r '.. | select(.focused? and .app_id=="apps.regreet")'
}
cur_focused=$(get_focused)
while [[ -z $cur_focused ]]; do
    cur_focused=$(get_focused)
done
swaymsg 'move output DP-1'
swaymsg '[app_id="apps.regreet"] focus'
# and wait for regreet's end
wait $p
killall gammastep # idk why it doesn't get killed despite being spawned by sway
swaymsg exit
