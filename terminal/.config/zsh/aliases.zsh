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
alias alacrittyconfig="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/alacritty"
alias kittyconfig="$EDITOR $DOTFILES_DIR/terminal/.config/kitty/"
alias tmuxconfig="$EDITOR $DOTFILES_DIR/terminal/.config/tmux"
alias hyprconfig="$EDITOR $DOTFILES_DIR/hyprland/.config/"

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'
# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'
