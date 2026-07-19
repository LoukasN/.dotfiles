#!/usr/bin/env bash

PrerequisitePackages=(
    "which" "unzip" "tree-sitter-cli"
)

EssentialPackages=(
	"kitty" "rofi" "neovim" "mako" "zsh" "waybar" "papirus-icon-theme" "zoxide" "hyprland" "slurp" "grim" "hypridle" "hyprlock" "awww" "blueman" "eza" "starship" )

OptionalPackages=(
	"thunar" "tumbler" "thunar-volman" "thunar-archive-plugin" "yazi" "btop" "qt5ct" "zathura" "nwg-look" "fzf" "ripgrep"
)

Fonts=(
	"ttf-nerd-fonts-symbols" "ttf-dejavu-nerd" "ttf-hack-nerd" "ttf-jetbrains-mono-nerd" "ttf-martian-mono-nerd" "wqy-microhei" "noto-fonts" "noto-fonts-emoji "
)

ConfigDirs=(
	"foot" "kitty" "rofi" "mako" "hypr" "nvim" "yazi" "rofi" "tmux/plugins" "waybar" "zsh/plugins"
)

# needed skips installed and up-to-date
# noconfirm removes confirmation
PackageManager="pacman --needed --noconfirm -S"

function InstallApps {
	for package in "$@"; do
		sudo bash -c "$PackageManager $package"
	done
}

echo "-----------------------"
echo "Starting install script"
echo "-----------------------"

# Directories
echo "- Creating directories in .config"
for dir in "${ConfigDirs[@]}"; do
	mkdir -p "$HOME/.config/$dir"
done
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/Pictures/wallpapers"

# Packages
echo "Updating system packages"
sudo pacman -Syu --noconfirm
echo "Installing packages"
InstallApps "${PrerequisitePackages[@]}"
InstallApps "${EssentialPackages[@]}"
while true; do
	read -p "Do you want to install optional packages? (y/n)" confirmation
	if [[ $confirmation =~ ^[yY]$ ]]; then
		echo "Installing optional packages"	
		InstallApps "${OptionalPackages[@]}"
		break
	elif [[ $confirmation =~ ^[nN]$ ]]; then
		echo "Not installing optional packages"
		break
	else
		echo "Invalid input. Enter 'y' or 'n'"
	fi
done
echo "Installing fonts"
InstallApps "${Fonts[@]}"

# Stow
InstallApps "stow"
echo "- Using stow for configurations"
if [[ -d ".dotfiles" ]]; then
	cd ".dotfiles" || exit
	stow --adopt .
else
	echo ".dotfiles directory not found"
fi

# Change the shell
if [[ $SHELL =~ /zsh$ ]]; then
	echo "- Shell is already set to zsh"
else
	echo "- Changing user shell to zsh"
	chsh --shell "$(which zsh)" "$USER"
fi

echo "-- Script is done."
echo "Please log out and log back in for the changes to take effect :)"
exit 0
