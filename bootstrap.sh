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
CONFIG_DIRS=("alacritty" "bspwm" "fish" "nvim")

# Iterate over each configuration directory
for DIR in "${CONFIG_DIRS[@]}"
do
	TARGET_FILE="$HOME/.config/$DIR"
	rm -rf "$HOME/.config/$DIR"
	ln -s "$HOME/dotfiles/$DIR" "$HOME/.config"
	echo "$TARGET_FILE created!"
done

