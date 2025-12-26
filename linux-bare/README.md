# Linux Bare Environment (Servers/Headless)

Minimal configuration for SSH servers and headless workstations.

## Setup
```bash
# Install oh-my-zsh (if not present)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install minimal packages
sudo apt install zsh neovim git  # Debian/Ubuntu
# or
sudo pacman -S zsh neovim git    # Arch

# Apply dotfiles
cd ~/doot && ./setup.sh linux-bare
```

## What's Included

### Shell
- **zsh** with oh-my-zsh (robbyrussell theme)
- Minimal plugins: git only
- Basic aliases: `v` (nvim), `ls`, `ll`, `la`

### Editor
- **neovim** - configs from `common/nvim/`

## What's NOT Included
- No GUI tools (sway, waybar, etc.)
- No desktop notifications
- No clipboard managers
- No fancy CLI tools (bat, eza, fzf) - install manually if needed
- No conda/nvm - add to `.zshrc` if required

## Optional Additions

If you need more tools on a specific server, install manually:

```bash
# Debian/Ubuntu
sudo apt install bat fd-find fzf ripgrep tmux

# Arch
sudo pacman -S bat fd fzf ripgrep tmux
```

Then add aliases to `~/.zshrc.local` (sourced if exists):
```bash
alias cat="bat --theme=Nord"
alias ls="eza --icons --color=always"
```
