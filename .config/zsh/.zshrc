# export plugins dir variable
export ZPLUGSDIR=${ZPLUGSDIR:-${XDG_DATA_HOME}/zsh}
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

# NVM variables
export NVM_AUTO_USE=true
export NVM_COMPLETION=true

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Source custom aliases
source "$ZDOTDIR/aliases.zsh"
source "$HOME/.aliases"

# ZSH functions path
fpath+=${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zsh_functions

# ============ PyEnv configuration section ============
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# ============ NodEnv configuration section ============
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# Source fzf for zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# This needs to be at the end of the file
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
