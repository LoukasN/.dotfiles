############-Configurations for zsh-############
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export ZDOTDIR=$HOME/.config/zsh 
export QT_QPA_PLATFORMTHEME=qt5ct
export PATH=$PATH:$HOME/.cargo/bin
################################################

# Java fix for fonts
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

# Local ruby
export GEM_HOME="$HOME/.gem"
export PATH="$HOME/.gem/bin:$PATH"

# Set misc environment variables
export EDITOR=nvim
export BROWSER=firefox

# Start hyprland
if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec uwsm start hyprland
fi
