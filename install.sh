#!/usr/bin/env bash

EssentialPackages=(
	"foot" "rofi" "neovim" "ly" "mako" "zsh" "waybar" "papirus-icon-theme" "zoxide" "hyprland" "slurp" "grim" "hypridle" "hyprlock" "swww" "blueman"
)

OptionalPackages=(
	"thunar" "yazi" "btop" "qt5ct" "zathura" "nwg-look" "fzf" "ripgrep"
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

printf "-----------------------\n"
printf "Starting install script\n"
printf "-----------------------\n\n"

# Directories
printf "- Creating directories in .config\n"
for dir in "${ConfigDirs[@]}"; do
	mkdir -p "$HOME/.config/$dir"
done
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/Pictures/wallpapers"

# Packages
printf "Updating system packages\n"
sudo pacman -Syu --noconfirm
printf "Installing packages\n"
InstallApps "${EssentialPackages[@]}"
while true; do
	read -p "Do you want to install optional packages? (y/n)" confirmation
	if [[ $confirmation =~ ^[yY]$ ]]; then
		printf "Installing optional packages\n"	
		InstallApps "${OptionalPackages[@]}"
		break
	elif [[ $confirmation =~ ^[nN]$ ]]; then
		printf "Not installing optional packages\n"
		break
	else
		printf "Invalid input. Enter 'y' or 'n'\n"
	fi
done
printf "Installing fonts\n"
InstallApps "${Fonts[@]}"

# PowerLevel10k
printf "- Installing powerlevel10k from git into GitApps directory\n"
if [[ ! -d "$HOME/GitApps" ]]; then
	mkdir -p ~/GitApps
fi
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/GitApps/powerlevel10k

# Stow
InstallApps "stow"
printf "- Using stow for configurations\n"
if [[ -d ".dotfiles" ]]; then
	cd ".dotfiles" || exit
	stow --adopt .
else
	printf ".dotfiles directory not found\n"
fi

# Change the shell
if [[ $SHELL =~ /zsh$ ]]; then
	printf "- Shell is already set to zsh\n"
else
	printf "- Changing user shell to zsh\n"
	chsh --shell "$(which zsh)" "$USER"
fi

# Enabling login manager
# Get the name of the login manager
displayManager=$(systemctl status display-manager.service | grep "loaded" | awk '{print $3}' | cut -d '.' -f 1 | rev | cut -d '/' -f 1 | rev)
# If ly is not enabled
if [[ $displayManager != "ly" ]]; then
	while true; do
		# Ask to enable
		read -p "Disable the current login manager ($displayManager) for ly? (y/n)" confirmDisplay
		if [[ $confirmDisplay =~ ^[yY]$ ]]; then
			# Disable the current manager
			sudo systemctl disable $displayManager
			# Enable ly
			sudo systemctl enable ly
			break
		elif [[ $confirmDisplay =~ ^[nN]$ ]]; then
			# Else exit
			break
		else
			printf "Invalid input. Enter 'y' or 'n'\n"
		fi
	done
fi

printf "-- Script is done. Please log out and log back in for the changes to take effect :)\n"
exit 0
