#!/usr/bin/env bash

EssentialPackages=(
	"kitty" "rofi" "neovim" "mako" "zsh" "waybar" "papirus-icon-theme" "zoxide" "hyprland" "slurp" "grim" "hypridle" "hyprlock" "awww" "blueman" "eza"
)

OptionalPackages=(
	"thunar" "tumbler" "thunar-volman" "thunar-archive-plugin" "yazi" "btop" "qt5ct" "zathura" "nwg-look" "fzf" "ripgrep"
)

Fonts=(
	"ttf-nerd-fonts-symbols" "ttf-dejavu-nerd" "ttf-hack-nerd" "ttf-jetbrains-mono-nerd" "ttf-martian-mono-nerd" "wqy-microhei" "noto-fonts"
)

ConfigDirs=(
	"foot" "rofi" "mako" "hypr" "nvim" "yazi" "rofi" "tmux/plugins" "waybar" "zsh/plugins"
)

# needed skips installed and up-to-date
# noconfirm removes confirmation
PackageManager="pacman --needed --noconfirm -S"

function InstallApps {
	for package in "$@"; do
		sudo bash -c "$PackageManager $package"
	done
}

echo "-----------------------\n"
echo "Starting install script\n"
echo "-----------------------\n\n"

# Directories
echo "- Creating directories in .config\n"
for dir in "${ConfigDirs[@]}"; do
	mkdir -p "$HOME/.config/$dir"
done
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/Pictures/wallpapers"

# Packages
echo "Updating system packages\n"
sudo pacman -Syu --noconfirm
echo "Installing packages\n"
InstallApps "${EssentialPackages[@]}"
while true; do
	read -p "Do you want to install optional packages? (y/n)" confirmation
	if [[ $confirmation =~ ^[yY]$ ]]; then
		echo "Installing optional packages\n"	
		InstallApps "${OptionalPackages[@]}"
		break
	elif [[ $confirmation =~ ^[nN]$ ]]; then
		echo "Not installing optional packages\n"
		break
	else
		echo "Invalid input. Enter 'y' or 'n'\n"
	fi
done
echo "Installing fonts\n"
InstallApps "${Fonts[@]}"

# PowerLevel10k
echo "- Installing powerlevel10k from git into GitApps directory\n"
if [[ ! -d "$HOME/GitApps" ]]; then
	mkdir -p ~/GitApps
fi
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/GitApps/powerlevel10k

# Stow
InstallApps "stow"
echo "- Using stow for configurations\n"
if [[ -d ".dotfiles" ]]; then
	cd ".dotfiles" || exit
	stow --adopt .
else
	echo ".dotfiles directory not found\n"
fi

# Change the shell
if [[ $SHELL =~ /zsh$ ]]; then
	echo "- Shell is already set to zsh\n"
else
	echo "- Changing user shell to zsh\n"
	chsh --shell "$(which zsh)" "$USER"
fi

echo "-- Script is done. Please log out and log back in for the changes to take effect :)\n"
exit 0
