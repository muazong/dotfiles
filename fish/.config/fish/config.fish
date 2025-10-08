# Set fish greeting
set --erase fish_greeting
set fish_greeting

# Set fish startup
if command -v starship > /dev/null
    starship init fish | source
else
    echo "Starship not found"
end

if command -v zoxide > /dev/null
    zoxide init fish | source
else
    echo "Zoxide not found"
end

if command -v atuin > /dev/null
    atuin init fish | source
else
    echo "Atuin not found"
end

if test -f ~/.env.fish
    source ~/.env.fish
end

set --export EDITOR nvim

# Aliases
alias suspend 'hyprlock & systemctl suspend'
alias logout 'sudo loginctl terminate-user $USER'
alias shutdown 'sudo systemctl poweroff'
alias poweroff 'sudo systemctl poweroff'
alias reboot 'sudo systemctl reboot'
alias lock 'hyprlock'

alias cls 'clear'
alias x 'exit'

alias l 'eza --icons=always'
alias ls 'eza --icons=always'
alias ll 'eza -lg --icons=always'
alias la 'eza -lag --icons=always'
alias lt 'eza -lTg --icons=always'
alias lt2 'eza -lTg --level=2 --icons=always'
alias lt3 'eza -lTg --level=3 --icons=always'
alias lta 'eza -lTag --icons=always'
alias lta2 'eza -lTag --level=2 --icons=always'
alias lta3 'eza -lTag --level=3 --icons=always'

alias t 'tmux attach'
alias tm 'tmux'

alias v 'nvim'
alias nv 'nvim'
alias vim 'nvim -u ~/.config/nvim-basic/init.lua'
alias nvc 'z ~/.config/nvim && nvim'

alias gp 'git push'
alias gc 'git commit'
alias gs 'git status'
alias gd 'git diff'

alias neo 'neofetch'
alias fast 'fastfetch'

alias lg 'lazygit'

alias gdisplay 'env XDG_CURRENT_DESKTOP=gnome gnome-control-center display'

# Bun
if [ -d "$HOME/.bun" ]
    set --export BUN_INSTALL "$HOME/.bun"
    set --export PATH $BUN_INSTALL/bin $PATH
end

# Dotnet
if [ -d "/home/azong/.dotnet/tools" ]
    set --export PATH $PATH /home/azong/.dotnet/tools
end

# Ruby
if [ -d /root/.local/share/gem/ruby/3.4.0/bin ]
    set --export PATH /root/.local/share/gem/ruby/3.4.0/bin $PATH
end

if [ -d ~/.local/share/gem/ruby/3.4.0/bin ]
    set --export PATH ~/.local/share/gem/ruby/3.4.0/bin $PATH
end

set -U fish_autosuggestion_enabled 1
set -U fish_complete_mode pager

# --- Completion menu ---
set -U fish_pager_color_prefix bryellow
set -U fish_pager_color_completion 7aa2f7
set -U fish_pager_color_description 565f89
set -U fish_pager_color_progress c0caf5
set -U fish_color_selection --background=2a2e36 --foreground=e6c384

# --- Autosuggestion ---
set -U fish_color_autosuggestion 545c7e

# --- Errors & highlights ---
set -U fish_color_error e46876
set -U fish_color_command 7dcfff
set -U fish_color_param dcd7ba
set -U fish_color_quote e6c384
set -U fish_color_operator 957fb8

# --- Pager titles (header line) ---
set -U fish_pager_color_prefix e6c384
set -U fish_pager_color_selected_background --background=2a2e36

# --- Extra touch for Kanagawa vibe ---
set -U fish_color_comment 565f89
set -U fish_color_end e46876
set -U fish_color_escape e6c384
set -U fish_color_valid_path 7aa2f7
