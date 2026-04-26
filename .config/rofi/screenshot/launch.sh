#!/usr/bin/env bash

## Author  : Hexagon16 (aka mbaraa)
## Github  : @mbaraa

DIR="$HOME/.config/rofi/screenshot"
theme="$DIR/style.rasi"

prompt='Screenshot'
mesg="DIR: `xdg-user-dir PICTURES`/Screens"

list_col='1'
list_row='5'
win_width='400px'

option_1="Capture Desktop"
option_2="Capture Area"
option_3="Capture Window"
option_4="Capture in 2s"
option_5="Capture in 5s"

rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: " ";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

DIR="`xdg-user-dir PICTURES`/Screens"
FILE_NAME="screen@$(date +"%Y-%m-%d %H:%M:%S.%N").png"
OUTPUT_FILE_PATH="$DIR/$FILE_NAME"

if [[ ! -d "$DIR" ]]; then
	mkdir -p "$DIR"
fi

countdown () {
	for sec in `seq $1 -1 1`; do
		notify-send "'bout to take a screenshot" "Taking shot in : $sec"
		sleep 1
	done
}

notify() {
    notify-send "Screenshot taken" "screenshot saved to $OUTPUT_FILE_PATH." -i "$OUTPUT_FILE_PATH"
}

screenshot() {
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

    wl-paste | cat > "$OUTPUT_FILE_PATH"
}

shotnow () {
    screenshot full
    notify
}

shot_wait () {
    time=$1
    geometry="$(slurp)"
	countdown $time
    grim -g "$geometry" - | wl-copy
    wl-paste | cat > "$OUTPUT_FILE_PATH"
    notify
}

shotwin () {
    screenshot window
    notify
}

shotarea () {
    screenshot region
    notify
}

run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		shotnow
	elif [[ "$1" == '--opt2' ]]; then
		shotarea
	elif [[ "$1" == '--opt3' ]]; then
		shotwin
	elif [[ "$1" == '--opt4' ]]; then
		shot_wait 2
	elif [[ "$1" == '--opt5' ]]; then
		shot_wait 5
	fi
}

chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
esac
