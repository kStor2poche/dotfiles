#! /bin/bash
# lil' script for adjusting sound with a cool notification

vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d" " -f2)
micmute=$(pactl get-source-mute @DEFAULT_SOURCE@ | cut -d" " -f2)
if [[ $mute = "yes" ]]; then
    vol_icon="muted"
elif [[ $vol -le 33 ]]; then
    vol_icon="low"
elif [[ $vol -le 66 ]]; then
    vol_icon="medium"
else
    vol_icon="high"
fi

if [[ $vol -le 33 ]]; then
    mute_icon="low"
elif [[ $vol -le 66 ]]; then
    mute_icon="medium"
else
    mute_icon="high"
fi

case "$1" in
    d)
        if [[ vol -ne 0 ]]; then
            newval=$((vol - 1))
        else
            newval=$vol
        fi
        notify-send -a "sound.sh" -u normal -t 1250 -e -h 'string:synchronous:sound.sh' -i "/usr/share/icons/Papirus/48x48/status/notification-audio-volume-${vol_icon}.svg" -h int:value:"$newval" "Volume" "${newval}"%
        if pactl set-sink-volume @DEFAULT_SINK@ "${newval}"%; then
            exit 0
        fi
        swaynag -t error -m "Could not set sound to '$newval'"
        exit 1
        ;;
    u)
        if [[ vol -ne 100 ]]; then
            newval=$((vol + 1))
        else
            newval=$vol
        fi
        notify-send -a "sound.sh" -u normal -t 1250 -e -h 'string:synchronous:sound.sh' -i "/usr/share/icons/Papirus/48x48/status/notification-audio-volume-${vol_icon}.svg" -h int:value:"$newval" "Volume" "${newval}"%
        if pactl set-sink-volume @DEFAULT_SINK@ "${newval}"%; then
            exit 0
        fi
        swaynag -t error -m "Could not set sound to '$newval'"
        exit 1
        ;;
    bd)
        if [[ vol -ne 0 ]]; then
            newval=$((vol - 5))
        elif [[ vol -le 5 ]]; then
            newval='0'
        else
            newval=$vol
        fi
        notify-send -a "sound.sh" -u normal -t 1250 -e -h 'string:synchronous:sound.sh' -i "/usr/share/icons/Papirus/48x48/status/notification-audio-volume-${vol_icon}.svg" -h int:value:"$newval" "Volume" "${newval}"%
        if pactl set-sink-volume @DEFAULT_SINK@ "${newval}"%; then
            exit 0
        fi
        swaynag -t error -m "Could not set sound to '$newval'"
        exit 1
        ;;
    bu)
        if [[ vol -le 95 ]]; then
            newval=$((vol + 5))
        elif [[ vol -gt 95 ]]; then
            newval='100'
        else
            newval=$vol
        fi
        notify-send -a "sound.sh" -u normal -t 1250 -e -h 'string:synchronous:sound.sh' -i "/usr/share/icons/Papirus/48x48/status/notification-audio-volume-${vol_icon}.svg" -h int:value:"$newval" "Volume" "${newval}"%
        if pactl set-sink-volume @DEFAULT_SINK@ "${newval}"%; then
            exit 0
        fi
        swaynag -t error -m "Could not set sound to '$newval'"
        exit 1
        ;;
    m)
        if [[ $mute = "no" ]]; then
        notify-send -a "sound.sh" -u normal -t 1250 -e -h 'string:synchronous:sound.sh' -i "/usr/share/icons/Papirus/48x48/status/notification-audio-volume-muted.svg" -h int:value:"$vol" "Volume" "Sourdine"
            pactl set-sink-mute @DEFAULT_SINK@ yes
        else
        notify-send -a "sound.sh" -u normal -t 1250 -e -h 'string:synchronous:sound.sh' -i "/usr/share/icons/Papirus/48x48/status/notification-audio-volume-${mute_icon}.svg" -h int:value:"$vol" "Volume" "${vol}"%
            pactl set-sink-mute @DEFAULT_SINK@ no
        fi
        exit 0
        ;;
    mm)
        if [[ $micmute = "no" ]]; then
        notify-send -a "sound.sh" -u normal -t 1250 -e -h 'string:synchronous:sound.sh' -i "/usr/share/icons/Papirus/48x48/status/microphone-sensitivity-muted.svg" "Microphone" "Sourdine"
            pactl set-source-mute @DEFAULT_SOURCE@ yes
        else
        notify-send -a "sound.sh" -u normal -t 1250 -e -h 'string:synchronous:sound.sh' -i "/usr/share/icons/Papirus/48x48/status/microphone-sensitivity-high.svg" "Microphone" "À l'écoute"
            pactl set-source-mute @DEFAULT_SOURCE@ no
        fi
        exit 0
        ;;
    *)
        swaynag -t warning -m "Error either in sway config file or $0"
        exit 1
esac
