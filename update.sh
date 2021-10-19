#!/bin/sh
# Update flake.lock
nix-shell -p nixUnstable --command "nix flake update --experimental-features 'nix-command flakes'"
