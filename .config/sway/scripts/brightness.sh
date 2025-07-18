#!/usr/bin/env bash

brightness=$(brightnessctl | grep Current | awk -F '(' '{print $2}' | cut -d ')' -f 1)
echo $brightness
