# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a dotfiles repository ("doot") managed with GNU Stow, supporting multiple environments:
- **mac** - macOS desktop
- **linux** - Full Linux desktop (Sway/Wayland)
- **linux-bare** - Servers and headless workstations

## Commands

**Setup (auto-detects OS):**
```bash
./setup.sh
```

**Setup with specific profile:**
```bash
./setup.sh mac
./setup.sh linux
./setup.sh linux-bare
```

**Install packages (Arch Linux):**
```bash
yay -S --needed - < pkglist-arch.txt
```

## Directory Structure

```
doot/
├── common/        # Universal packages (always stowed)
│   ├── nvim/      # Neovim (Lazy.nvim, LSP)
│   ├── alacritty/ # Terminal emulator
│   └── zathura/   # PDF viewer
├── mac/           # macOS-specific
│   └── zsh/       # Shell config (Homebrew, nvm, conda)
├── linux/         # Linux desktop (Sway/Wayland)
│   ├── zsh/       # Shell config (pacman, fcitx)
│   ├── sway/      # Window manager
│   ├── waybar/    # Status bar
│   ├── dunst/     # Notifications
│   ├── wofi/      # App launcher
│   ├── gammastep/ # Blue light filter
│   ├── scripts/   # Wayland utilities
│   └── wallpapers/
└── linux-bare/    # Servers/headless
    └── zsh/       # Minimal shell config
```

## How setup.sh Works

1. Detects OS (Darwin → mac, Linux → linux)
2. On Linux, checks for GUI ($DISPLAY or $WAYLAND_DISPLAY) - defaults to linux-bare if none
3. Stows all packages from `common/`
4. Stows all packages from the detected OS directory
