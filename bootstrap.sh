#!/usr/bin/bash

DOTDIR="$HOME/.dotfiles"

# Check if packages are installed, and only install them if they're not
for package in openssh github-cli fish neovim bspwm sxhkd rofi; do
    if ! pacman -Q $package &>/dev/null; then
        echo "$package not found, installing..."
        pacman -S --noconfirm $package
    else
        echo "$package is already installed"
    fi
done

# Check if symlinks already exist, and only create them if they don't
create_symlink() {
    local target=$1
    local link_name=$2
    if [ ! -L "$link_name" ]; then
        echo "Creating symlink for $link_name"
        rm -rf "$link_name"  # Remove if it exists as a file or dir
        ln -sf "$target" "$link_name"
    else
        echo "Symlink for $link_name already exists, skipping"
    fi
}

# Linking configurations
create_symlink "$DOTDIR/.config/bspwm" "$HOME/.config/bspwm"
echo "Done linking bspwm"

create_symlink "$DOTDIR/.config/sxhkd" "$HOME/.config/sxhkd"
echo "Done linking sxhkd"

create_symlink "$DOTDIR/.config/nvim" "$HOME/.config/nvim"
echo "Done linking nvim"

create_symlink "$DOTDIR/.config/rofi" "$HOME/.config/rofi"
echo "Done linking rofi"

create_symlink "$DOTDIR/.config/fish" "$HOME/.config/fish"
echo "Done linking fish"

echo "Done!"
