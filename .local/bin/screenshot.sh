#!/usr/bin/env bash
fileName="$(date +%F_%H-%M-%S)"
grim ~/Pictures/screenshots/"$fileName.png"
wl-copy --type image/png < ~/Pictures/screenshots/"$fileName.png"
notify-send 'Screen captured and copied to clipboard'
