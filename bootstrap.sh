#!/usr/bin/env fish

# Install Oh My Fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

if ! command -v paru &> /dev/null
	cd /tmp
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si
  echo "paru installed"
	rm -rf /tmp/paru
else
	echo "paru is already installed!"
end

paru -S alacritty bspwm sxhkd neovim rofi ranger neofetch flameshot

# Installing rust things
cargo install zoxide
cargo install starship

chmod +x $HOME/.dotfiles/bspwm/bspwmrc
chmod +x $HOME/.dotfiles/bspwm/sxhkdrc

printf "\nCreating symbolic links\n"

set CONFIG_DIR $HOME/.config

# Iterate over each configuration directory
set DIRS alacritty bspwm fish nvim rofi

for DIR in $DIRS
  rm -rf $CONFIG_DIR/$DIR
  ln -s $HOME/.dotfiles/$DIR $CONFIG_DIR
  echo "$DIR config created"
end

rm -rf "$HOME/.gitconfig"
ln -s "$HOME/.dotfiles/.gitconfig" "$HOME"

rm -rf "$HOME/.xinitrc"
ln -s "$HOME/.dotfiles/.xinitrc" "$HOME"

set -U fish_user_paths $fish_user_path "$HOME/.dotfiles/rofi/scripts"
