# Install paru

echo "[*] Checking if paru is installed"

if ! command -v paru &> /dev/null
then
	echo "paru not found, installing..."
	cd /tmp
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si
	rm -rf /tmp/paru
else
	echo "paru is already installed!"
fi

printf "\nCreating symbolic links\n"

# List of configuration directories
CONFIG_DIRS=("alacritty" "bspwm" "fish")

# Iterate over each configuration directory
for DIR in "${CONFIG_DIRS[@]}"
do
    TARGET_FILE="$HOME/.config/$DIR"
    
    if test -L "$TARGET_FILE"; then
        echo "$TARGET_FILE exists."
    else
        ln -s "~/.dotfiles/$DIR" "$HOME/.config"
        echo "$TARGET_FILE created!"
    fi
done

paru -S --noconfirm neovim ranger rofi feh dunst net-tools neofetch lolcat noto-fonts-emoji fortune-mod archlinux-keyring bspwm sxhkd discord fish flameshot gzip inetutils lsof nodejs npm pavucontrol python python-pip rustup sddm sddm-sugar-dark telegram-desktop thunar thunar-volman tmux ttf-jetbrains-mono-nerd unzip visual-studio-code-bin vivaldi  

# Install rust

rustup install stable
rustup default stable

# cargo install

cargo install ytop exa bat zoxide ripgrep starship

