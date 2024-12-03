if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x BUN_INSTALL "$HOME/.bun"
set -x PATH $BUN_INSTALL/bin $PATH
set -x PATH "$HOME/.config/rofi" $PATH

alias p3="python3"
alias ct="cargo test"
alias cr="cargo run"
alias pd="pnpm dev"
alias pps="pnpm prisma studio"
alias nv="nvim"
alias ls="exa"
