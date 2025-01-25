# Set fish greeting
set --erase fish_greeting
set fish_greeting

# Set fish startup
eval "$(starship init fish)"
eval "$(zoxide init fish)"

# Aliases
alias suspend='systemctl suspend'

alias cls='clear'
alias x='exit'

alias t='tmux attach'
alias tm='tmux'

alias v='nvim'
alias nv='nvim'

alias neo='neofetch'
alias fast='fastfetch'
