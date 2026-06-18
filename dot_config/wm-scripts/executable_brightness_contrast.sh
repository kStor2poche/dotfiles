#! /bin/bash
# lil' script for adjusting screen brightness over ddc with a cool notification

sleep_mul=".1" # 1 is the minimum for set, .1 the minimum for get
opts=(
    "--skip-ddc-checks"
    "--noconfig"
    "--brief"
)
bus=/tmp/ddcutil.bus
refresh_bus() {
    bus_no=$(ddcutil -t detect | grep -B1 "DP-1" | head -1)
    bus_no=${bus_no: -1}
    echo -ne "$bus_no" > $bus
}

if [[ ! -f $bus ]]; then
    refresh_bus
else
    bus_no=$(cat $bus)
fi

get_brightval() {
    ddcutil "${opts[@]}" --bus "$bus_no" getvcp 10 --sleep-multiplier "$sleep_mul" | cut -d' ' -f4
}

get_contrastval() {
    ddcutil "${opts[@]}" --bus "$bus_no" getvcp 12 --sleep-multiplier "$sleep_mul" | cut -d' ' -f4
}

send_brightness_notif() {
    newval=$1
    level=$2
    notify-send -a "brightness_constrast.sh" -u normal -t 1250 -e -h "string:synchronous:brightness_constrast.sh" -h "int:value:$newval" -i "/usr/share/icons/Papirus/48x48/status/notification-display-brightness-${level}.svg" "Luminosité" "${newval}%"
}

send_contrast_notif() {
    newval=$1
    level=$2
    notify-send -a "brightness_constrast.sh" -u normal -t 1250 -e -h "string:synchronous:brightness_constrast.sh" -h "int:value:$newval" -i "/usr/share/icons/Papirus/48x48/status/notification-display-brightness-${level}.svg" "Contraste" "${newval}%"
}

case "$1" in
    bda)
        newval=0
        send_brightness_notif $newval "low"
        if ddcutil "${opts[@]}" --bus "$bus_no" setvcp 10 "$newval" --sleep-multiplier "$sleep_mul"; then
            exit 0
        fi
        exit 1
        ;;
    bd)
        brightval=$(get_brightval)
        if [[ $brightval -ne 0 ]];then
            newval=$(( brightval - 5 ))
        else
            newval=0
        fi
        send_brightness_notif $newval "low"
        if ddcutil "${opts[@]}" --bus "$bus_no" setvcp 10 "$newval" --sleep-multiplier "$sleep_mul"; then
            exit 0
        fi
        exit 1
        ;;
    bua)
        newval=50
        send_brightness_notif $newval "high"
        if ddcutil "${opts[@]}" --bus "$bus_no" setvcp 10 "$newval" --sleep-multiplier "$sleep_mul"; then
            exit 0
        fi
        exit 1
        ;;
    bu)
        brightval=$(get_brightval)
        if [[ $brightval -ne 50 ]];then
            newval=$(( brightval + 5 ))
        else
            newval=50
        fi
        send_brightness_notif $newval "high"
        if ddcutil "${opts[@]}" --bus "$bus_no" setvcp 10 "$newval" --sleep-multiplier "$sleep_mul"; then
            exit 0
        fi
        exit 1
        ;;
    cda)
        newval=0
        send_contrast_notif $newval "low"
        if ddcutil "${opts[@]}" --bus "$bus_no" setvcp 12 "$newval" --sleep-multiplier "$sleep_mul"; then
            exit 0
        fi
        exit 1
        ;;
    cd)
        contrastval=$(get_contrastval)
        if [[ $contrastval -ne 0 ]];then
            newval=$(( contrastval - 5 ))
        else
            newval=0
        fi
        send_contrast_notif $newval "low"
        if ddcutil "${opts[@]}" --bus "$bus_no" setvcp 12 "$newval" --sleep-multiplier "$sleep_mul"; then
            exit 0
        fi
        exit 1
        ;;
    cua)
        newval=50
        send_contrast_notif $newval "high"
        if ddcutil "${opts[@]}" --bus "$bus_no" setvcp 12 "$newval" --sleep-multiplier "$sleep_mul"; then
            exit 0
        fi
        exit 1
        ;;
    cu)
        contrastval=$(get_contrastval)
        if [[ $contrastval -ne 50 ]];then
            newval=$(( contrastval + 5 ))
        else
            newval=50
        fi
        send_contrast_notif $newval "high"
        if ddcutil "${opts[@]}" --bus "$bus_no" setvcp 12 "$newval" --sleep-multiplier "$sleep_mul"; then
            exit 0
        fi
        exit 1
        ;;
    *)
        notify-send -a "brightness_constrast.sh" -u critical -e -h "string:synchronous:brightness_constrast.sh" -i "/usr/share/icons/Papirus/48x48/apps/system-error.svg" "Erreur" "Dans la configuration WM ou ${0}"
esac
