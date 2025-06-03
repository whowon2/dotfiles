#!/usr/bin/bash

DOTDIR="$HOME/.dotfiles"

# Check if packages are installed, and only install them if they're not
for package in openssh gnome-keyring github-cli fish neovim telegram-desktop unzip rust pavucontrol nvidia-settings zoxide starship; do
    if ! pacman -Q $package &>/dev/null; then
        echo "$package not found, installing..."
        paru -S --noconfirm $package
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
        echo "Symlink created for $link_name"
    else
        echo "Symlink for $link_name already exists, updating"
        rm -rf "$link_name"
        ln -sf "$target" "$link_name"
        echo "Symlink updated for $link_name"
    fi
}

# Linking configurations
create_symlink "$DOTDIR/.gitconfig" "$HOME/.gitconfig"

create_symlink "$DOTDIR/fish" "$HOME/.config/fish"

create_symlink "$DOTDIR/ghostty" "$HOME/.config/ghostty"

create_symlink "$DOTDIR/hypr" "$HOME/.config/hypr"

create_symlink "$DOTDIR/waybar" "$HOME/.config/waybar"

create_symlink "$DOTDIR/.zed" "$HOME/.config/zed"

echo "Done!"
