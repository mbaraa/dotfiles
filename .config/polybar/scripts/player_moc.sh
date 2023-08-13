#!/bin/sh

if [ "$(mocp -Q %state)" != "STOP" ];then
    SONG=$(mocp -Q %song)

    if [ -n "$SONG" ]; then
        echo " $SONG"
    else
        basename "$(mocp -Q %file)"
    fi
else
    echo ""
fi
# - $(mocp -Q %artist)
