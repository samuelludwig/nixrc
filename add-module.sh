#!/bin/sh
mkdir -p "./modules/user/$1"
echo "{ ... }: {}" > "./modules/user/$1/default.nix"
