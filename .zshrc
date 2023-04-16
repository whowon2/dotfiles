export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions) 

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/.local/bin

alias v="lvim"
alias ls="exa"
alias lh="exa -ah"
