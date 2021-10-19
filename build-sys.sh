#!/bin/sh
# Build system config.
# pushd ~/.dotfiles
sudo nixos-rebuild switch --flake .#
# popd
