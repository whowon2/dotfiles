if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish | source
starship init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

alias p3="python3"
alias ct="cargo test"
alias cr="cargo run"
alias pd="pnpm dev"
alias pps="pnpm prisma studio"
alias nv="nvim"

# pnpm
set -gx PNPM_HOME "/home/rusarc/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
