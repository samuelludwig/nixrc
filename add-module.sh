#!/bin/sh
# Just a stupid simple sort of templating utility for new modules.
mkdir -p "./modules/user/$1"
echo "{ ... }: {}" > "./modules/user/$1/default.nix"
