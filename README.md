# Doot for dotfiles

## Setup dotfiles
1. Clone to $HOME directory:
2. Use GNU Stow to apply config
```
cd doot
stow */
```

## Install necessary packages
1. Install yay aur manager
```
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
2. Install packages using yay from pkglist
```
yay -S --needed - < pkglist.txt
```

## TODO:
[] Add optional install scripts for certain features
    [] caps to control, esc
    [] bluetooth
    [] wifi
