# Common Packages (Universal)

These configs are stowed on all systems (mac, linux, linux-bare).

## Packages

| Package | Description |
|---------|-------------|
| nvim | Neovim config with Lazy.nvim, LSP, Treesitter |
| alacritty | GPU-accelerated terminal emulator |
| zathura | Vim-like PDF viewer |

## Neovim Structure (Kickstart.nvim)

```
nvim/.config/nvim/
├── init.lua              # Main config (all-in-one)
├── lazy-lock.json        # Plugin versions
└── lua/
    ├── custom/plugins/   # Your custom plugins
    └── kickstart/plugins/ # Optional kickstart modules
        ├── autopairs.lua
        ├── debug.lua
        ├── gitsigns.lua
        ├── indent_line.lua
        ├── lint.lua
        └── neo-tree.lua
```
