# export plugins dir variable
export ZPLUGSDIR="$HOME/.local/share/zsh"
# Add local user bin to PATH
export PATH="$PATH:$HOME/.local/bin"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
export DOTFILES_DIR="$HOME/dotfiles"
# History settings
[[ ! -d "$ZSH_CACHE_DIR" ]] && mkdir -p "$ZSH_CACHE_DIR" || true
export HISTFILE="$ZSH_CACHE_DIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10200
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
#setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

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

# ============ GO configuration section =============
export GOPATH="$HOME/go"
export PATH="$HOME/go/bin:$PATH"

# Shell completions
# PNPM is a special case
[[ -f "$ZDOTDIR/completions/_pnpm.zsh" ]] && source "$ZDOTDIR/completions/_pnpm.zsh" || true
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

fpath+=$ZDOTDIR/completions
fpath+=$ZDOTDIR/completions/distrobox
autoload -U compinit
compinit

# Source fzf for zsh
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# This needs to be at the end of the file
# To customize prompt, run `p10k configure` or edit $HOME/.config/zsh/.p10k.zsh.
[[ ! -f $HOME/.config/zsh/.p10k.zsh ]] || source $HOME/.config/zsh/.p10k.zsh
export PATH=$PATH:$HOME/.spicetify

