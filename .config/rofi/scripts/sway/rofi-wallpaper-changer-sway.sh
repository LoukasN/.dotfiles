#!/usr/bin/env bash
dir="/home/$USER/Pictures/wallpapers/" # Wallpaper directory
ConfigFile="/home/$USER/.config/sway/config" # The config for the script to write to
mode="fill"	# The mode that the image will be scaled
primaryMonitor=$(swaymsg -t get_outputs --pretty | grep Output | awk -F ' ' '{print $2}' | head -n '1') # Name of the main monitor
secondaryMonitor=$(swaymsg -t get_outputs --pretty | grep Output | awk -F ' ' '{print $2}' | tail -n '1') # Name of the second monitor
input=$(cat $ConfigFile | grep "fill") # Get previous wallpapers lines from file
PreviousPrimary=$(echo -e $input | grep $primaryMonitor | awk -F ' ' '{print $4}' | cut -d '/' -f 6) # Get previous primary wallpapers name
PreviousSecondary=$(echo -e $input | grep $secondaryMonitor | awk -F ' ' '{print $9}' | cut -d '/' -f 6) # Get previous secondary wallpapers name
if [ $primaryMonitor != $secondaryMonitor ]; then
	TwoMonitors=true
fi

SelectPic(){
	# Shows the directory in rofi
	wallpaper=$(ls $dir | rofi -dmenu -p "Select wallpaper")
	if [[ $wallpaper == "q" || $wallpaper == "" ]]; then
		# If nothing is chosen it closes
		exit 
	else
		SetWallpaper
	fi
}

selectmonitor(){
	# Shows the rofi menu
	monitor=$(echo -e "Primary\nSecondary" | rofi -dmenu -p "Select monitor")
	# Checks which monitors wallpaper will be changed
	if [ $monitor == "Primary" ]; then
		PrimaryWallpaper=$wallpaper
		SecondaryWallpaper=$PreviousSecondary
	elif [ $monitor == "Secondary" ]; then
		PrimaryWallpaper=$PreviousPrimary
		SecondaryWallpaper=$wallpaper
	else
		exit
	fi
}

SetWallpaper(){
	if [ $TwoMonitors ]; then
		selectmonitor
	else
		PrimaryWallpaper=$wallpaper
		SecondaryWallpaper=$PreviousPrimary
	fi
	# Delete previous entries
	sed -i '/wallpapers/d' $ConfigFile
	sed -i ' /This 3 lines are written by the script/d' $ConfigFile
	# Write new entries
	echo -e "# This 3 lines are written by the script located in ~/.config/rofi/rofi-wallpaper-changer-sway" >> $ConfigFile
	echo "output $primaryMonitor bg $dir$PrimaryWallpaper $mode" >> $ConfigFile
	if [ $TwoMonitors ]; then
		echo "output $secondaryMonitor bg $dir$SecondaryWallpaper $mode" >> $ConfigFile
	fi
	# Reload sway
	swaymsg reload
}


SelectPic
