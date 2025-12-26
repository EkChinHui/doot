# Linux Bare .zshrc (servers/headless)

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Locale
export LANG=en_US.UTF-8

# Oh My Zsh (minimal)
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR=nvim
export VISUAL=nvim

# Aliases
alias v="nvim"
alias ls="ls --color=auto"
alias ll="ls -la"
alias la="ls -A"
alias l="ls -CF"
alias sa="source .venv/bin/activate"

# NVM (if installed)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
