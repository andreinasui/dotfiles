# load zgenom
# make sure zgenom is installed
if [[ ! -d "$ZPLUGSDIR/zgenom" ]]; then
  git clone https://github.com/jandamm/zgenom "$ZPLUGSDIR/zgenom"
fi

source  "$ZPLUGSDIR/zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then
    echo "Creating a zgenom save"

    # Add this if you experience issues with missing completions or errors mentioning compdef.
    # zgenom compdef

    # Theme
    zgenom load romkatv/powerlevel10k powerlevel10k

    # Ohmyzsh base library
    zgenom ohmyzsh

    # Ohmyzsh plugins
    zgenom ohmyzsh plugins/sudo
    zgenom ohmyzsh plugins/docker --completion
    zgenom ohmyzsh plugins/z 

    # other plugins
    zgenom load zsh-users/zsh-syntax-highlighting
    zgenom load zsh-users/zsh-completions
    zgenom load lukechilds/zsh-better-npm-completion

    # save all to init script
    zgenom save

    # Compile your zsh files
    # zgenom compile "$ZDOTDIR/.zshrc"
    zgenom compile $ZDOTDIR

    # You can perform other "time consuming" maintenance tasks here as well.
    # If you use `zgenom autoupdate` you're making sure it gets
    # executed every 7 days.

    # rbenv rehash
fi
