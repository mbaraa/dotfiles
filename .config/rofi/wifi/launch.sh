#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi/wifi"
style="style.rasi"

# Get current connection status
active_ssr=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
if [ -z "$active_ssr" ]; then
    msg="Disconnected"
else
    msg="Connected to: $active_ssr"
fi

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "Wi-Fi" \
        -mesg "$msg" \
        -theme ${dir}/${style}
}

# Scan and list Wi-Fi networks
# We filter out empty SSIDs and format the list
list_wifi() {
    nmcli --terse --fields "SECURITY,SSID" device wifi list | \
    sed 's/WPA*/ /g; s/^--/ /g; s/ :/ /g' | \
    sort -u
}

# Main Logic
chosen_network=$(list_wifi | rofi_cmd)

# Exit if nothing is chosen
if [ -z "$chosen_network" ]; then
    exit 0
fi

# Extract the SSID (removing the icon prefix)
ssid=$(echo "$chosen_network" | sed 's/^ //; s/^ //')

# Check if already connected
if [ "$ssid" == "$active_ssr" ]; then
    nmcli device disconnect wlan0
else
    # Check if network is known (saved)
    success=$(nmcli -t -f NAME connection show | grep -x "$ssid")

    if [ -n "$success" ]; then
        nmcli connection up "$ssid"
    else
        # Ask for password if unknown
        pass=$(rofi -dmenu -p "Password" -theme-str 'mainbox {children: [ "inputbar" ];}' -theme ${dir}/${style})
        if [ -n "$pass" ]; then
            nmcli device wifi connect "$ssid" password "$pass"
        fi
    fi
fi
