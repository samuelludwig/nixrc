# NIXRC

At this moment, these configs prioritize non-NixOS Nix installations. In other
words, Nix (with the `nix-command` and `flake` features enabled) is installed,
and you want to use Home-Manager to manage your programs dotfiles. That is my
particular use-case for the time being.

This repo provides a script, `init-repo.sh`, which will need to be run from the
root of the repo whenever it's cloned/copied over. This will determine a couple
sensible default/utility values (i.e. your current username, your home
directory, and where the repo lives on your filesystem).

## Use

0) Install Nix if you have not already.

0.5) Enable flake-use if you have not already, via:

Running `nix-env -iA nixpkgs.nixUnstable`

And adding `experimental-features = nix-command flakes` to
`~/.config/nix/nix.conf`.

1) Clone the repo: `git clone git@github.com:samuelludwig/nixrc.git`

2) `cd` into the repo.

3) Run `./init-repo.sh` (this will populate the `metaInfo.nix` file with some
important stuff).

4) Run `./build-usr <config-name>`, which will build and activate the chosen
home-manager config.


## Initially available Configs

These can all be found/modified in `flake.nix`:

- `linux-server` <- Just some terminal apps, a safe enough start
- `garuda-desktop` <- Untested
- `nixos-desktop` <- Untested

## Module philosophy

I try to keep modules as self contained as possible, if one module is turned
off or removed, there shouldn't be any edits needed to other files. This does
beget some repetition and fragmentation as a tradeoff however.

## Install cachix

```
nix-env -iA cachix -f https://cachix.org/api/v1/install
```

## TODO

add cachix settings to home manager config
