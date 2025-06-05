#!/bin/bash
alias shreload='source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshrc'
alias nvpn=nordvpn

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
# alias rm='rm -i'

# configuration files aliases
alias i3config="$EDITOR $DOTFILES_DIR/i3/.config/"

alias zshconfig="$EDITOR $ZDOTDIR"
alias aliasconfig="$EDITOR $ZDOTDIR/aliases.zsh"
alias p10kconfig="$EDITOR $ZDOTDIR/.p10k.zsh"
alias nvimconfig="$EDITOR $DOTFILES_DIR/terminal/.config/nvim"
alias kittyconfig="$EDITOR $DOTFILES_DIR/terminal/.config/kitty/"
alias tmuxconfig="$EDITOR $DOTFILES_DIR/terminal/.config/tmux"
alias hyprconfig="$EDITOR $DOTFILES_DIR/hyprland/.config/"

alias notes="$EDITOR /home/andrei/notes/"

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'
# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# git aliases
alias ga='git add'
alias gaa='git add --all'
alias gap='ga --patch'
alias gb='git branch'
alias gba='gb --all'
alias gc='git commit'
alias gcam='gc -a --amend --no-edit'
alias gce='gc --amend'
alias gco='git checkout'
alias gcl='git clone --recursive'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias gds='gd --staged'
alias gi='git init'
alias glg='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias gm='git merge'
alias gn='git checkout -b'  # new branch
alias gp='git push'
alias gr='git reset'
alias gst='git status --short'
alias gu='git pull'
