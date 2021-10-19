#!/bin/sh
# Record some information about the repo and current user to determine
# appropriate defaults.
echo "{ repoDir = \"$(pwd)\"; username = \"$USER\"; homeDir = \"$HOME\"; }" > metaInfo.nix
