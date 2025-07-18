#!/usr/bin/env bash
dir="/home/$USER/Pictures/wallpapers/" # Wallpaper directory
wallpaper="none" 
command="exec_always --no-startup-id sleep 1 && feh --bg-fill" # what command is writen in the configm
ConfigFile="/home/$USER/.config/i3/config" # The file that the wallpaper config is written on
connected_monitors=$(xrandr --listactivemonitors | grep "+" | wc -l) # checks number of monitors
input=$(cat ~/.config/i3/config | grep "\--bg-fill") #
PreviousPrimary=$(echo $input | awk -F '/wallpapers/' '{print $2}' | cut -d ' ' -f 1)
PreviousSecondary=$(echo $input | awk -F '/wallpapers/' '{print $3}')
cd $dir

# Selecting the monitor (Only used with dual monitors)
selectmonitor(){
	monitor=$(echo -e "Primary\nSecondary" | rofi -dmenu -p "Select monitor")
	if [[ $monitor == "Primary" ]]; then
		Primary=$wallpaper
		Secondary=$PreviousSecondary
	elif [[ $monitor == "Secondary" ]]; then
		Primary=$PreviousPrimary
		Secondary=$wallpaper
	fi
}

# Selecting wallpaper
selectpic(){
    wallpaper=$(ls $dir | rofi -dmenu -p "Select wallpaper")

    if [[ $wallpaper == "q" || $wallpaper == "" ]]; then
        killall feh && exit 
    else
		SetWallpaper
    fi
}

# Setting permanent wallpapers
SetWallpaper(){
  if [[ $connected_monitors == "2" ]]; then 
	selectmonitor
  elif [[ $connected_monitors == "1" ]]; then
	Primary=$wallpaper
	Secondary=$PreviousSecondary
  fi 

  sed -i '/feh/d' $ConfigFile
  echo -e "# This 3 lines are written by the script (uses feh) located in ~/.config/rofi/rofi-wallpaper-changer\n# Changing wallpaper using feh" >> $ConfigFile
  echo "$command $dir$Primary $dir$Secondary" >> $ConfigFile
  i3-msg restart
}

selectpic
