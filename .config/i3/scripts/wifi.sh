#!/usr/bin/env bash

# Getting the wifi card id 
DEVICE=$(nmcli d | grep wifi | cut -d ' ' -f 1)
# Connected networks name
SSID=$(nmcli d | grep wifi | cut -d ' ' -f 26)
# Connection status connected/disconnected
STATUS=$(nmcli d | grep wifi | cut -d ' ' -f 11)
# Signal strenght
SIGNAL=$(nmcli -f IN-USE,SIGNAL device wifi list | grep "*" | cut -d ' ' -f 8)

if [[ $STATUS == "connected" ]]; then
	if [[ $SIGNAL < 50 ]]; then
		echo $SSID
		echo
		echo \#FFFF00
	else
		echo $SSID
		echo
		echo \#00FF00
	fi
elif [[ $STATUS == "unavailable" ]]; then
	echo "Wifi: down"
	echo 
	echo \#FF0000
else 
	echo "Wifi: Disconnected"
	echo
	echo \#FF0000
fi
