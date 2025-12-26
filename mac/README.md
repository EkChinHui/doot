# macOS Environment

## Setup
```bash
# Install packages
brew bundle --file=~/doot/mac/Brewfile

# Apply dotfiles
cd ~/doot && ./setup.sh mac
```

## Packages

### Window Management
| Package | Description |
|---------|-------------|
| aerospace | Tiling window manager for macOS (i3-like) |
| alt-tab | Windows-style alt-tab switcher with previews |

### Menu Bar
| Package | Description |
|---------|-------------|
| sketchybar | Customizable status bar replacement |
| hiddenbar | Hide menu bar icons |
| stats | System monitor (CPU, memory, disk, network) |

### Terminal Emulators
| Package | Description |
|---------|-------------|
| alacritty | GPU-accelerated terminal |
| ghostty | Fast, native terminal by Mitchell Hashimoto |

### CLI Tools
| Package | Description |
|---------|-------------|
| bat | `cat` with syntax highlighting and git integration |
| eza | Modern `ls` replacement with icons and colors |
| fd | Fast, user-friendly `find` alternative |
| fzf | Fuzzy finder for files, history, etc. |
| ripgrep | Fast `grep` alternative |
| stow | Symlink manager for dotfiles |
| tmux | Terminal multiplexer |
| wget | File downloader |
| direnv | Per-directory environment variables |
| yazi | Terminal file manager with image preview |

### Editor
| Package | Description |
|---------|-------------|
| neovim | Hyperextensible Vim-based text editor |

### Keyboard
| Package | Description |
|---------|-------------|
| kanata | Keyboard remapping (caps to ctrl/esc, layers) |

### Media
| Package | Description |
|---------|-------------|
| yt-dlp | Download videos from YouTube and other sites |

### Fonts
| Package | Description |
|---------|-------------|
| font-hack-nerd-font | Patched font with icons for terminal |
