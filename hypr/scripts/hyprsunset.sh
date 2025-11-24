#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
    pkill hyprsunset
    notify-send "Hyprsunset" "Hyprsunset has been stopped"
else
    hyprsunset -t 6000
    notify-send "Hyprsunset" "Hyprsunset started with 6000K temperature"
fi