
#!/usr/bin/env bash
set -euo pipefail

DOTDIR="$HOME/.dotfiles"
INTERACTIVE=true  # Set to false to skip prompts

# Color codes
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
RESET='\033[0m'

info()    { echo -e "${GREEN}[INFO]${RESET} $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET} $*"; }
error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; }
prompt()  { read -rp "$(echo -e "${YELLOW}[PROMPT]${RESET} $* [y/N]: ")" ans; [[ $ans == [Yy]* ]]; }


# Backup function
backup_existing() {
    local file=$1
    local backup="${file}.backup"

    if [ -e "$file" ] && [ ! -L "$file" ]; then
        if $INTERACTIVE; then
            if prompt "$file exists. Backup and overwrite?"; then
                mv "$file" "$backup"
                info "Backed up $file to $backup"
            else
                warn "Skipped $file"
                return 1
            fi
        else
            mv "$file" "$backup"
            info "Backed up $file to $backup"
        fi
    fi
}

# Symlink function
create_symlink() {
    local target=$1
    local link_name=$2

    if [ -L "$link_name" ]; then
        info "Updating existing symlink: $link_name"
        ln -sf "$target" "$link_name"
    elif [ -e "$link_name" ]; then
        if backup_existing "$link_name"; then
            info "Creating symlink: $link_name"
            ln -s "$target" "$link_name"
        fi
    else
        info "Creating symlink: $link_name"
        ln -s "$target" "$link_name"
    fi
}

# Link top-level dotfiles
create_symlink "$DOTDIR/.gitconfig" "$HOME/.gitconfig"

# Link .config contents individually
info "Linking .config items..."
for file in "$DOTDIR/config/"*; do
    name=$(basename "$file")
    create_symlink "$file" "$HOME/.config/$name"
done

info "Dotfiles setup complete!"
