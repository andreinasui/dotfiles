#!/bin/bash
alias shreload='source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshrc'
alias nvpn=nordvpn

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
# alias rm='rm -i'

# configuration files aliases
alias i3config="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/i3"
alias polybarconfig="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/polybar"
alias picomconfig="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/picom"
alias zshconfig="$EDITOR $ZDOTDIR"
alias aliasconfig="$EDITOR $ZDOTDIR/aliases.zsh"
alias p10kconfig="$EDITOR $ZDOTDIR/.p10k.zsh"
alias nvimconfig="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
alias alacrittyconfig="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/alacritty/alacritty.yml"
alias tmuxconfig="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
alias hyprconfig="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprland.conf"
# TODO: create alias using fd fzf-tmux and nvim to open a file fast

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'
# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'
