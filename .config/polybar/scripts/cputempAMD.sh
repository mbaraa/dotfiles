#!/bin/sh

sensors | grep Tdie   | awk '{print substr($2, 1,  length($2)-2)}' | tr "\\n" " " | sed 's/ /°C  /g' | sed 's/  $//'
