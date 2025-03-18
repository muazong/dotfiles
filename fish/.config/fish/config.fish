# Set fish greeting
set --erase fish_greeting
set fish_greeting

# Set fish startup
if command -v starship > /dev/null
    starship init fish | source
end

if command -v zoxide > /dev/null
    zoxide init fish | source
end

# Aliases
alias suspend='loginctl lock-session & systemctl suspend'
alias logout='sudo loginctl kill-session $XDG_SESSION_ID'
alias shutdown='sudo systemctl poweroff'
alias reboot='sudo systemctl reboot'
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
alias vim='nvim -u ~/.config/nvim-basic/init.lua'
alias nvc='z ~/.config/nvim && nvim'

alias gp='git push'
alias gc='git commit'
alias gs='git status'
alias gd='git diff'

alias neo='neofetch'
alias fast='fastfetch'

alias lg='lazygit'

# Bun
if [ -d "$HOME/.bun" ]
  set --export BUN_INSTALL "$HOME/.bun"
  set --export PATH $BUN_INSTALL/bin $PATH
end

# Dotnet
if [ -d "/home/azong/.dotnet/tools" ]
  set --export PATH $PATH:/home/azong/.dotnet/tools
end
