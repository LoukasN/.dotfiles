#!/usr/bin/env bash

WallpaperDir="/home/$USER/Pictures/wallpapers/" # Wallpaper dir
ConfigLocation="/home/$USER/.config/hypr/autostart.lua" # The config file to edit
PrevWallpaper=$(cat "$ConfigLocation" | grep "awww img" | awk -F '/' '{print $4}' | awk -F '"' '{print $1}') # Get previous wallpapers lines from file)

SelectPic(){
    # Shows the wallpaper selection menu in rofi
    Wallpaper=$(ls "$WallpaperDir" | rofi -dmenu -i -p "Select wallpaper")
    if [[ $Wallpaper == "q" || $Wallpaper == "" ]]; then
        exit
    else
        SetWallpaper
    fi
}

SetWallpaper(){
    sed -i -e "s/$PrevWallpaper/$Wallpaper/g" "$ConfigLocation"
}

SelectPic
exit
