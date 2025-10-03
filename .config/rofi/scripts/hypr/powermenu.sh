#!/usr/bin/env bash
 
shutdown=" Poweroff"
restart=" Restart"
logout="󰍃 Logout"
sleep="󰤄 Suspend"
lock=" Lock"
 
selected_option=$(echo "$shutdown
$restart
$logout
$sleep
$lock" | rofi -dmenu -i -p "Powermenu" -theme "$HOME/.config/rofi/themes/Casual-Dark-PowerMenu.rasi")

if [ "$selected_option" == "$lock" ]
then
	loginctl lock-session
	exit
elif [ "$selected_option" == "$logout" ]
then
	hyprctl dispatch exit 1
	exit
elif [ "$selected_option" == "$shutdown" ]
then
	systemctl poweroff
	exit
elif [ "$selected_option" == "$restart" ]
then
	systemctl reboot
	exit
elif [ "$selected_option" == "$sleep" ]
then
	systemctl suspend
	exit
fi
