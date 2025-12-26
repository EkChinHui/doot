# Linux Desktop Environment (Sway/Wayland)

## Setup
```bash
# Install packages (Arch Linux)
yay -S --needed - < ~/doot/pkglist-arch.txt

# Apply dotfiles
cd ~/doot && ./setup.sh linux
```

## Packages

### Window Manager
| Package | Description |
|---------|-------------|
| sway | Tiling Wayland compositor (i3-compatible) |
| swayidle | Idle management daemon |
| swaylock | Screen locker |

### Status Bar
| Package | Description |
|---------|-------------|
| waybar | Highly customizable status bar for Sway |

### Notifications
| Package | Description |
|---------|-------------|
| dunst | Lightweight notification daemon |

### Launchers
| Package | Description |
|---------|-------------|
| wofi | Application launcher for Wayland (rofi-like) |

### Display
| Package | Description |
|---------|-------------|
| gammastep | Blue light filter (redshift for Wayland) |

### Screenshots & Recording
| Package | Description |
|---------|-------------|
| grim | Screenshot tool for Wayland |
| slurp | Region selector for Wayland |
| wf-recorder | Screen recorder for Wayland |

### Clipboard
| Package | Description |
|---------|-------------|
| clipman | Clipboard manager for Wayland |
| wl-clipboard | Command-line clipboard utilities |

### Input Method
| Package | Description |
|---------|-------------|
| fcitx | Input method framework (Japanese, Chinese, etc.) |
| fcitx-mozc | Japanese input |

### Audio
| Package | Description |
|---------|-------------|
| pulseaudio | Sound server |
| pavucontrol | PulseAudio volume control GUI |

### Terminal Emulators
| Package | Description |
|---------|-------------|
| alacritty | GPU-accelerated terminal |

### CLI Tools
| Package | Description |
|---------|-------------|
| bat | `cat` with syntax highlighting |
| exa/eza | Modern `ls` replacement |
| fd | Fast `find` alternative |
| fzf | Fuzzy finder |
| ripgrep | Fast `grep` alternative |
| stow | Dotfiles manager |
| yazi | Terminal file manager |

### Editor
| Package | Description |
|---------|-------------|
| neovim | Vim-based text editor |

### File Manager
| Package | Description |
|---------|-------------|
| thunar | GTK file manager |

### PDF Viewer
| Package | Description |
|---------|-------------|
| zathura | Vim-like PDF viewer |

### Media
| Package | Description |
|---------|-------------|
| mpv | Minimal video player |
| vlc | Full-featured media player |

## Custom Scripts

Located in `scripts/.config/scripts/`:

| Script | Description |
|--------|-------------|
| screenshot.sh | Screenshot with region selection via wofi |
| volume.sh | Volume control with dunst notifications |
| wallpaper.sh | Wallpaper setter using swaybg |
| select_scripts.sh | Script launcher via wofi |
