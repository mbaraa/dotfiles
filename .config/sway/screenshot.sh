#!/usr/bin/env bash

MODE=$1

case "$MODE" in
    "full")
        grim - | wl-copy
        ;;
    "region")
        grim -g "$(slurp)" - | wl-copy
        ;;
    "window")
        swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select(.focused) | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)"' | grim -g - - | wl-copy
        ;;
    *)
        ;;
esac

FILE_NAME="screen@$(date +"%Y-%m-%d %H:%M:%S.%N").png"
OUTPUT_FILE_PATH="$HOME/General/Groot/Screens/$FILE_NAME"

wl-paste | cat > "$OUTPUT_FILE_PATH"

notify-send "Screenshot taken" "screenshot saved to $OUTPUT_FILE_PATH." -i "$OUTPUT_FILE_PATH"
