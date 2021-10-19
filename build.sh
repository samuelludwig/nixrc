pushd ~/.dotfiles
nix-shell -p nixUnstable --command "nix build --experimental-features 'nix-command flakes' .#homeManagerConfigurations.'$HOSTNAME'.activationPackage"
./result/activate
popd
