{
  inputs = {
    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";

    #
    # Package Repos
    #
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-master.url = "github:NixOS/nixpkgs";
    #nixpkgs-2009.url = "github:NixOS/nixpkgs/nixos-20.09";
    #nur.url = "github:nix-community/NUR";

  };

  outputs = inputs@{ self, nixpkgs, fup, ... }:
    let pkgs = nixpkgs.legacyPackages;
    in fup.lib.mkFlake {
      inherit self inputs;
    };
}
