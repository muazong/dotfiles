[[ $- != *i* ]] && return

export PATH="$HOME/.local/bin:$PATH"
eval "$(zoxide init bash)"

export OSH=~/.local/.oh-my-bash
OSH_THEME="font"
OMB_USE_SUDO=true
completions=(git composer ssh)
aliases=(general)
plugins=(git bashmarks)
source "$OSH"/oh-my-bash.sh

alias l='eza --icons=always'
alias ls='eza --icons=always'
alias ll='eza -lg --icons=always'
alias la='eza -lag --icons=always'

alias lg='lazygit'
alias gp 'git push'
alias gc 'git commit'
alias gs 'git status'
alias gd 'git diff'

alias grep='grep --color=auto'

alias t 'tmux attach'
alias tm 'tmux'

alias nv='nvim'
alias nvc 'z ~/.config/nvim && nvim'

export PS1='[\u@\h \[\e[32m\]\w\[\e[0m\]]\$ '

