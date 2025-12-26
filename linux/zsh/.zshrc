# Linux Desktop .zshrc (Arch/Sway)

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.gem/bin:$PATH"

# Locale
export LANG=en_US.UTF-8

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Input method (fcitx)
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# Oh My Zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="hyperzsh"
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions direnv)
source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR=nvim
export VISUAL=nvim

# Aliases - Config
alias zconf="nvim ~/.zshrc"
alias conf="cd ~/.config"
alias sconf="nvim ~/.config/sway/config"
alias vconf="nvim ~/.config/nvim/init.lua"
alias vpconf="nvim ~/.config/nvim/lua/plugins.lua"
alias tconf="nvim ~/.tmux.conf"

# Aliases - Tools
alias cat="bat --theme=Nord"
alias ls="eza --icons --color=always --group-directories-first"
alias v="nvim"
alias z="zathura --fork"
alias sa="source .venv/bin/activate"

# Aliases - Package management
alias p="sudo pacman"
alias yay="yay"

# Yazi file manager
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# NVM (if installed)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
