export QT_QPA_PLATFORMTHEME=qt6ct
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
export PATH=$PATH:$HOME/.cargo/bin
export PATH="$HOME/.gem/bin:$PATH"
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# Start hyprland
if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec start-hyprland
fi
