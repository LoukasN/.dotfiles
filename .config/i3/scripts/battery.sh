#!/usr/bin/env bash

BAT=$(acpi -b | grep -E -o '[0-9][0-9]%')
SINGLE_DIGIT_BAT=$(acpi -b | grep -E -o '[0-9]%')
REMAINING=$(acpi -b | grep -E -o '[0-9][0-9]:[0-9][0-9]')

if [[ $BAT > 30 ]]; then
	echo "$BAT $REMAINING"
elif [[ $BAT > 15 ]]; then
	echo "$BAT $REMAINING"
	echo
	echo \#FFFF00 #YELLOW
else
	echo "$SINGLE_DIGIT_BAT $REMAINING"
	echo
	echo \#FF0000 #RED
fi

exit 0
