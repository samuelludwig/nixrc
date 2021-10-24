#!/bin/sh
# Build and activate home-manager config for $MACHINE.
# pushd ~/.dotfiles
./init-repo.sh
nix build ".#homeManagerConfigurations.$1.activationPackage" && ./result/activate
# popd
