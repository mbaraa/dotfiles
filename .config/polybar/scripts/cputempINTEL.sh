#!/bin/sh

sensors | grep Package  | awk '{print substr($4, 2,  length($5)-1)}' | tr "\\n" " " | sed 's/ /°C  /g' | sed 's/  $//'
