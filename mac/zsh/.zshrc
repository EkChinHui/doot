# macOS .zshrc

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/development/flutter/bin:$PATH"
export PATH="$HOME/.gem/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Locale
export LANG=en_US.UTF-8

# Java / Android / Maven
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export M2_HOME="$HOME/Downloads/apache-maven-3.9.9"
export PATH="${M2_HOME}/bin:${PATH}"

# macOS-specific
export GTK_USE_PORTAL=0
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Oh My Zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="hyperzsh"
COMPLETION_WAITING_DOTS="true"
plugins=(git uv zsh-syntax-highlighting zsh-autosuggestions direnv)
source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR=nvim
export VISUAL=nvim

# Aliases - Config
alias zconf="nvim ~/.zshrc"
alias conf="cd ~/.config"
alias vconf="nvim ~/.config/nvim/init.lua"
alias vpconf="nvim ~/.config/nvim/lua/plugins.lua"
alias tconf="nvim ~/.tmux.conf"

# Aliases - Tools
alias cat="bat --theme=Nord"
alias ls="eza --icons --color=always --group-directories-first"
alias v="nvim"
alias z="zathura --fork"
alias sa="source .venv/bin/activate"
alias ca="conda activate"

# Yazi file manager
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Conda
__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Misc
export KMP_DUPLICATE_LIB_OK=TRUE
ulimit -n 4096
