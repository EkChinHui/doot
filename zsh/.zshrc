# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set env variables

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
fi

# add to PATH
export PATH="$HOME/.local/bin:$PATH"
# export PATH="/opt/cuda/bin:$PATH"
# export LD_LIBRARY_PATH=/usr/local/lib/
export GTK_USE_PORTAL=0
export ZSH="/home/ch/.config/.oh-my-zsh"

ZSH_THEME="hyperzsh"

COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
export VISUAL=nvim

alias zconf="nvim ~/.zshrc"
alias conf="cd ~/.config"
alias sconf="nvim ~/.config/sway/config"
alias vconf="nvim ~/.config/nvim/init.lua"
alias vpconf="nvim ~/.config/nvim/lua/plugins.lua"
alias kconf="nvim ~/.config/kitty/kitty.conf"
alias stud="cd ~/studies/y3s2"
alias todo="nvim ~/studies/notes/todo.md"
alias s="nvim ~/studies/notes/scratch"
alias bl="nvim ~/studies/notes/backlog.md"
alias cat="bat --theme=Nord"
alias ls="exa --icons --color=always --group-directories-first"
alias kssh="kitty +kitten ssh"

alias v="nvim"
alias p="sudo pacman"
alias rgr="ranger"
alias z="zathura --fork"
alias zoom="QT_QPA_PLATFORM=xcb zoom &"
alias kt="kitty +kitten themes"


function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
  )
  ${ranger_cmd[@]} "$@"
  if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
    cd -- "$(cat "$tempfile")" || return
  fi
  command rm -f -- "$tempfile" 2>/dev/null
  command clear
}





alias luamake=/home/ch/projects/lua-language-server/3rd/luamake/luamake

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

