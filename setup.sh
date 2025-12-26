#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

# Detect OS
case "$(uname -s)" in
    Darwin) OS="mac" ;;
    Linux)  OS="linux" ;;
    *)      echo "Unsupported OS: $(uname -s)"; exit 1 ;;
esac

# On Linux, check for GUI (X11/Wayland) - default to bare if no display
if [[ "$OS" == "linux" ]] && [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" ]]; then
    OS="linux-bare"
fi

# Allow override via argument
if [[ -n "$1" ]]; then
    case "$1" in
        mac|linux|linux-bare) OS="$1" ;;
        *) echo "Usage: $0 [mac|linux|linux-bare]"; exit 1 ;;
    esac
fi

echo "Setting up dotfiles for: $OS"
echo "---"

# Stow common packages (universal CLI tools)
echo "Stowing common packages..."
for pkg in common/*/; do
    pkg_name=$(basename "$pkg")
    echo "  -> $pkg_name"
    stow -d common -t "$HOME" "$pkg_name"
done

# Stow OS-specific packages
echo "Stowing $OS packages..."
for pkg in "$OS"/*/; do
    pkg_name=$(basename "$pkg")
    echo "  -> $pkg_name"
    stow -d "$OS" -t "$HOME" "$pkg_name"
done

echo "---"
echo "Done! You may need to restart your shell."
