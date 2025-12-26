# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set env variables

# add to PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH=$HOME/development/flutter/bin:$PATH
export PATH=$HOME/.gem/bin:$PATH
export LANG=en_US.UTF-8
export M2_HOME="/Users/ecq964/Downloads/apache-maven-3.9.9"
PATH="${M2_HOME}/bin:${PATH}"
export PATH

# export PATH="/opt/cuda/bin:$PATH"
# export LD_LIBRARY_PATH=/usr/local/lib/
export GTK_USE_PORTAL=0
# export ZSH="/home/ch/.config/.oh-my-zsh"
export ANDROID_HOME=/Users/ecq964/Library/Android/sdk
ZSH_THEME="hyperzsh"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
COMPLETION_WAITING_DOTS="true"

# source /Users/ecq964/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

plugins=(git uv zsh-syntax-highlighting zsh-autosuggestions direnv)

export ZSH=$HOME/.oh-my-zsh/
source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
export VISUAL=nvim

alias zconf="nvim ~/.zshrc"
alias conf="cd ~/.config"
alias sconf="nvim ~/.config/sway/config"
alias vconf="nvim ~/.config/nvim/init.lua"
alias vpconf="nvim ~/.config/nvim/lua/plugins.lua"
alias kconf="nvim ~/.config/kitty/kitty.conf"
alias cat="bat --theme=Nord"
alias ls="eza --icons --color=always --group-directories-first"
alias tconf="nvim ~/.tmux.conf"
alias sa="source .venv/bin/activate"
# alias ts="tmux save-session -t work - > ~/work"
# alias lt="tmux source-file ~/work"

alias ca="conda activate"
alias v="nvim"
alias p="sudo pacman"
alias inno="ssh innovation-machine@192.168.9.227"
alias deploy="ssh deploy@192.168.9.227"
alias cdv="ssh cdv@192.168.1.90"
alias ch="ssh chinhui@192.168.9.227"
alias z="zathura --fork"
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ecq964/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ecq964/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ecq964/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ecq964/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# JINA_CLI_BEGIN

## autocomplete
if [[ ! -o interactive ]]; then
    return
fi

compctl -K _jina jina

_jina() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(jina commands)"
  else
    completions="$(jina completions ${words[2,-2]})"
  fi

  reply=(${(ps:
:)completions})
}

# session-wise fix
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# JINA_CLI_END



export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export KMP_DUPLICATE_LIB_OK=TRUE

# Added by Antigravity
export PATH="/Users/ecq964/.antigravity/antigravity/bin:$PATH"
