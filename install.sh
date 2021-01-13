#! /usr/bin/env bash

# Shows the output of every command
set +x

# Pin Nixpkgs to NixOS unstable on December 12th of 2020
export PINNED_NIX_PKGS="https://github.com/NixOS/nixpkgs/archive/e9158eca70a.tar.gz"

# Switch to the unstable channel
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos

# Nix configuration
sudo cp system/configuration.nix /etc/nixos/
sudo cp -r system/fonts/ /etc/nixos/
sudo cp -r system/machine/ /etc/nixos/
sudo cp -r system/wm/ /etc/nixos/
sudo nixos-rebuild -I nixpkgs=$PINNED_NIX_PKGS switch --upgrade

# Manual steps
mkdir -p $HOME/.config/polybar/logs
touch $HOME/.config/polybar/logs/bottom.log
touch $HOME/.config/polybar/logs/top.log
mkdir -p $HOME/.cache/fzf-hoogle
touch $HOME/.cache/fzf-hoogle/cache.json

# Home manager
mkdir -p $HOME/.config/nixpkgs/
cp -r home/* $HOME/.config/nixpkgs/
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install
cp home/nixos.png $HOME/Pictures/
home-manager switch

# Set user's profile picture for Gnome3
sudo cp home/gvolpe.png /var/lib/AccountsService/icons/julius
sudo echo "Icon=/var/lib/AccountsService/icons/julius" >> /var/lib/AccountsService/users/julius

# Set screenlock wallpaper
betterlockscreen -u home/nixos.png
