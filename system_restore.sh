#!/usr/bin/env bash

PYTHON_VERSION=3.12.7
NODE_VERSION=22.11.0
DOTFILES_DIR="$HOME/dotfiles"
DOWNLOADS_DIR="$HOME/Downloads"
APPS_DIR="$HOME/apps"
SPICETIFY_CONFIG_DIR="$HOME/.config/spicetify/"

_dotfiles_setup() {
	pushd "$DOTFILES_DIR" >/dev/null 2>&1
	stow terminal
	stow hyprland
	stow wallpapers
	popd >/dev/null 2>&1
}

_pyenv_setup() {
	set -e
	if command -v pyenv &>/dev/null; then
		return 0
	fi
	echo "Setting up python!"
	curl --silent https://pyenv.run | bash
	pyenv install $PYTHON_VERSION
	pyenv global $PYTHON_VERSION
	$(pyenv which python) -m pip install requests
	echo "Python installed! Global version set to $NODE_VERSION"
}

_nodenv_setup() {
	set -e
	if command -v nodenv &>/dev/null; then
		return 0
	fi
	echo "Setting up nodenv!"
	curl -fsSL https://github.com/nodenv/nodenv-installer/raw/HEAD/bin/nodenv-installer | bash
	nodenv install $NODE_VERSION
	nodenv global $NODE_VERSION
	echo "Node installed! Global version set to $NODE_VERSION"
}

_cargo_setup() {
	set -e
	curl -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
	echo "Rust and Cargo installed!"
}

_nvim_setup() {
	set -e
	pushd "$DOWNLOADS_DIR" >/dev/null 2>&1
	curl -sSLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	tar -C "$APPS_DIR" -xzf nvim-linux64.tar.gz
	rm nvim-linux64.tar.gz
	ln -sf "$APPS_DIR/nvim-linux64/bin/nvim" "$HOME/.local/bin/nvim"
	popd >/dev/null 2>&1
	echo "nvim installed!"
}

_fzf_setup() {
	set -e
	local fzf_home="$HOME/.fzf"
	pushd "$DOWNLOADS_DIR" >/dev/null 2>&1
	git -C "$fzf_home" pull --quiet origin HEAD >/dev/null 2>&1 || git clone --quiet --depth 1 https://github.com/junegunn/fzf.git "$fzf_home"
	bash -c "$fzf_home/install --no-bash --no-fish --no-update-rc --completion --key-bindings"
	popd >/dev/null 2>&1
	echo "fzf installed!"
}

_spicetify_setup() {
	set -e
	pushd "$DOWNLOADS_DIR" >/dev/null 2>&1
	curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sed 's/\/dev\/tty/\/dev\/null || exit 0/g' | sh >/dev/null 2>&1

	# Download theme
	git -C Spicetify-Lucid pull --quiet origin HEAD >/dev/null 2>&1 || git clone --quiet --depth=1 https://github.com/sanoojes/Spicetify-Lucid.git
	mkdir -p "$SPICETIFY_CONFIG_DIR/Themes/Lucid"
	cp -r Spicetify-Lucid/src/* "$SPICETIFY_CONFIG_DIR/Themes/Lucid"

	prefs_path="$HOME/.var/app/com.spotify.Client/config/spotify/prefs"
	sed -i -E "s+^(prefs_path\s*=\s*).*$+\1${prefs_path}+" "$(spicetify -c)"

	spicetify config spotify_path "/var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/"
	spicetify config current_theme Lucid color_scheme dark
	spicetify config extensions fullAppDisplay.js
	spicetify config custom_apps lyrics-plus
	spicetify config inject_css 1 replace_colors 1 overwrite_assets 1 inject_theme_js 1
	spicetify backup apply
	spicetify apply
	rm -rf spicetify-themes install.log

	echo "Spicetify installed and configured!"

	popd >/dev/null 2>&1

}

_extras_setup() {
	# Install fonts
	pushd "$DOWNLOADS_DIR" >/dev/null 2>&1
	curl -sSLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/RobotoMono.tar.xz
	mkdir -p "$HOME/.local/share/fonts/RobotoMono"
	tar -C "$HOME/.local/share/fonts/RobotoMono" -xf RobotoMono.tar.xz
	rm RobotoMono.tar.xz
	fc-cache -f
	# Themes - GTK
	git -C gruvbox-material-gtk pull --quiet origin HEAD || git clone --quiet --depth 1 https://github.com/TheGreatMcPain/gruvbox-material-gtk
	cp -r gruvbox-material-gtk/themes/* "$HOME/.local/share/themes"
	cp -r gruvbox-material-gtk/icons/* "$HOME/.local/share/icons"
	rm -rf gruvbox-material-gtk

	# Spicetify config
	_spicetify_setup
	popd >/dev/null 2>&1
}

_tools_setup() {
	_pyenv_setup
	_nodenv_setup
	_cargo_setup
	_nvim_setup
	_fzf_setup
}

_check_prereqs() {
	mkdir -p "$HOME/.local/bin"
	mkdir -p "$HOME/.local/share/fonts"
	mkdir -p "$HOME/.local/share/themes"
	mkdir -p "$HOME/.local/share/icons"
	mkdir -p "$APPS_DIR"
	mkdir -p "$SPICETIFY_CONFIG_DIR/Themes"

	if ! command -v curl &>/dev/null; then
		echo "curl is not installed!" >&2
		exit 1
	fi

	if ! command -v stow &>/dev/null; then
		echo "Stow is not installed! Please install it first." >&2
		exit 1
	fi

}

home_restore() {
	_check_prereqs
	_dotfiles_setup
	_tools_setup
	_extras_setup

}

# home_restore
home_restore
