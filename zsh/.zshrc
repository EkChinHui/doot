# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set env variables

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
fi

# add to PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/cuda/bin:$PATH"

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
alias stud="cd ~/studies/y3s1"
alias todo="nvim ~/studies/notes/todo.md"
alias s="nvim ~/studies/notes/scratch"
alias bl="nvim ~/studies/notes/backlog.md"
alias cat="bat --theme=Nord"
alias ls="exa --icons --color=always --group-directories-first"
alias kssh="kitty +kitten ssh"

alias v="nvim"
alias p="sudo pacman"
alias rg="ranger"
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

