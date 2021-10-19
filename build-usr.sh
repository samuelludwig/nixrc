#!/bin/sh
# pushd ~/.dotfiles
nix build .#homeManagerConfigurations."$1".activationPackage
./result/activate
# popd
