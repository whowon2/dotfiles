if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

zoxide init fish | source
starship init fish | source

alias bx="bun x"
alias bd="bun dev"
alias bt="bun test"
alias px="pnpm dlx"
alias pd="pnpm dev"
alias vim="nvim"
alias nv="nvim"

alias ch="git checkout"
alias chb="git checkout -b"
alias chm="git checkout main"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
