#! /bin/bash
# lil' script for adjusting screen brightness over ddc with a cool notification without sending two requests

scriptdir=$(dirname "$0")
brightval=$(cat "$scriptdir"/bright.save)

send_notif() {
    newval=$1
    level=$2
    notify-send -a "brightness.sh" -u normal -t 1250 -e -h "string:synchronous:brightness.sh" -h "int:value:$newval" -i "/usr/share/icons/Papirus/48x48/status/notification-display-brightness-${level}.svg" "Luminosité" "${newval}%"
}

case "$1" in
    d)
        if [[ $brightval -ne 0 ]];then
            newval=$(( brightval - 1 ))
            echo -n $newval > "$scriptdir"/bright.save
        else
            newval=0
        fi
        send_notif $newval low
        if brightnessctl --exponent=2 s "${newval}"%; then
            exit 0
        fi
        swaynag -t error -m "Could not set brightness to '$newval'"
        exit 1
        ;;
    u)
        if [[ $brightval -ne 100 ]];then
            newval=$(( brightval + 1 ))
            echo -n $newval > "$scriptdir"/bright.save
        else
            newval=100
        fi
        send_notif $newval high
        if brightnessctl --exponent=2 s "${newval}"%; then
            exit 0
        fi
        swaynag -t error -m "Could not set brightness to '$newval'"
        exit 1
        ;;
    bd)
        if [[ $brightval -ge 5 ]];then
            newval=$(( brightval - 5 ))
            echo -n $newval > "$scriptdir"/bright.save
        else
            newval=0
        fi
        send_notif $newval low
        if brightnessctl --exponent=2 s "${newval}"%; then
            exit 0
        fi
        swaynag -t error -m "Could not set brightness to '$newval'"
        exit 1
        ;;
    bu)
        if [[ $brightval -le 95 ]];then
            newval=$(( brightval + 5 ))
            echo -n $newval > "$scriptdir"/bright.save
        else
            newval=100
        fi
        send_notif $newval high
        if brightnessctl --exponent=2 s "${newval}"%; then
            exit 0
        fi
        swaynag -t error -m "Could not set brightness to '$newval'"
        exit 1
        ;;
    r)
        if brightnessctl --exponent=2 s "${brightval}%"; then
            exit 0
        else
            swaynag -t warning -m "Could not reset brightness"
            exit 1
        fi
        ;;
    *)
        swaynag -t warning -m "Error either in sway config file or $0"
esac
