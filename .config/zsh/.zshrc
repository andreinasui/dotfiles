# export plugins dir variable
export ZPLUGSDIR="$HOME/.local/share/zsh"
# Add local user bin to PATH
export PATH="$PATH:$HOME/.local/bin"
export HISTFILE="$XDG_CACHE_HOME/zsh/.zsh_history"

# Source plugins
source "$ZDOTDIR/plugins.zsh"

# Theme
[[ -d "$ZDOTDIR/plugins/themes/powerlevel10k" ]] && \
  source "$ZDOTDIR/plugins/themes/powerlevel10k/powerlevel10k.zsh-theme"

# ===== Variables defined for certain plugins =====
# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

export QT_QPA_PLATFORMTHEME="qt5ct" 

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Source custom aliases
source "$ZDOTDIR/aliases.zsh" 2>/dev/null
source "$HOME/.aliases" 2>/dev/null

# ZSH functions path
fpath+=${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zsh_functions


# ============ PyEnv configuration section ============
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# ============ NodEnv configuration section ============
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# ============ Cargo configuration section =============
export PATH="$HOME/.cargo/bin:$PATH"

# Shell completions
# uninstall by removing these lines
# pnpm completion
[[ -f ~/.config/zsh/completion/pnpm.zsh ]] && . ~/.config/zsh/completion/pnpm.zsh || true

# i3lock completion
[[ -f ~/.config/zsh/completion/i3lock.zsh ]] && . ~/.config/zsh/completion/i3lock.zsh || true

# rbw completion
[[ -f ~/.config/zsh/completion/rbw.zsh ]] && . ~/.config/zsh/completion/rbw.zsh || true

# Source fzf for zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# This needs to be at the end of the file
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
export PATH=$PATH:/home/andrei/.spicetify
