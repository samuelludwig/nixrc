{
  description = "Lorem Ipsum dolor";

  inputs = {
    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";

    #
    # Package Repos
    #
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ self, nixpkgs, fup, ... }:
    let
      pkgs = import nixpkgs { };
      inherit (fup.lib) mkFlake mkApp;
      pleaseGod = { };
    in mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      overlay = (final: prev: { inherit pleaseGod; });

      sharedOverlays = [ overlay ];

      outputsBulider = channels: {
        inherit overlay;

        packages.pleaseGod = pleaseGod;
        defaultPackage = packages.pleaseGod;

        apps.pleaseGod = mkApp { drv = packages.pleaseGod; };
        defaultApp = apps.pleaseGod;

        devShell = import ./shell.nix { 
          pkgs = channels.nixpkgs;
          devPackage = pleaseGod;
        };
      };
    };
}
