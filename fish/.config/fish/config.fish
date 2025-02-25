# Set fish greeting
set --erase fish_greeting
set fish_greeting

# Set fish startup
eval "$(starship init fish)"
eval "$(zoxide init fish)"

# Aliases
alias suspend='loginctl lock-session & systemctl suspend'
alias logout='loginctl kill-session $XDG_SESSION_ID'
alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias lock='loginctl lock-session'

alias cls='clear'
alias x='exit'

alias l="eza --icons=always"
alias ls="eza --icons=always"
alias ll="eza -lg --icons=always"
alias la="eza -lag --icons=always"
alias lt="eza -lTg --icons=always"
alias lt2="eza -lTg --level=2 --icons=always"
alias lt3="eza -lTg --level=3 --icons=always"
alias lta="eza -lTag --icons=always"
alias lta2="eza -lTag --level=2 --icons=always"
alias lta3="eza -lTag --level=3 --icons=always"

alias t='tmux attach'
alias tm='tmux'

alias v='nvim'
alias nv='nvim'
alias nvc='z ~/.config/nvim && nvim'

alias neo='neofetch'
alias fast='fastfetch'

alias lg='lazygit'

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
