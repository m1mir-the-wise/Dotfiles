#!/bin/bash

status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
connected=$(bluetoothctl info | grep "Connected: yes")

if [[ "$status" == "yes" ]]; then
    if [[ -n "$connected" ]]; then
        echo " 󰂱"
    else
        echo " 󰂯"
    fi
else
    echo " 󰂲" 
fi

