#!/usr/bin/env bash

# Directory for the theme
dir="$HOME/.config/rofi/music"
style="style.rasi"

# Get current status
status="$(playerctl status 2>/dev/null)"
artist="$(playerctl metadata artist 2>/dev/null)"
song="$(playerctl metadata title 2>/dev/null)"

if [[ "$status" == "Playing" ]]; then
    msg=" $artist - $song"
elif [[ "$status" == "Paused" ]]; then
    msg=" $artist - $song"
else
    msg="Offline"
fi

# Icons (Nerd Fonts)
prev='󰒮'
play='󰐎'
next='󰒭'
vol_up='󰝝'
vol_down='󰝞'
mute='󰝟'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "Music" \
        -mesg "$msg" \
        -theme "${dir}/${style}"
}

# Run UI and capture choice
chosen="$(echo -e "$prev\n$play\n$next\n$vol_up\n$vol_down\n$mute" | rofi_cmd)"

# Execution logic
case ${chosen} in
    "$prev")
        playerctl previous ;;
    "$play")
        playerctl play-pause ;;
    "$next")
        playerctl next ;;
    "$vol_up")
        pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
    "$vol_down")
        pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
    "$mute")
        pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
esac
