#!/usr/bin/env bash

fileName="$(date +%F_%H-%M-%S)"
grim -g "$(slurp)" ~/Pictures/screenshots/"$fileName.png"
wl-copy --type image/png < ~/Pictures/screenshots/"$fileName.png"
notify-send  'Screenshot captured and copied to clipboard'
