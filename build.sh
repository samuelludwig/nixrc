# build-usr script but assuming that nixUnstable isn't installed
pushd ~/.dotfiles
./init-repo.sh
nix-shell -p nixUnstable --command "nix build --experimental-features 'nix-command flakes' .#homeManagerConfigurations.'$1'.activationPackage"
./result/activate
popd
