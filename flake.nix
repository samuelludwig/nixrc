{
  description = "System & home configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    copier-pkgs-preview.url = "github:jonringer/nixpkgs/package-copier";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cachix.url = "github:cachix/cachix";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    telescope-fzf-native = {
      url = "github:nvim-telescope/telescope-fzf-native.nvim";
      flake = false;
    };

    fish-fasd = {
      url = "github:oh-my-fish/plugin-fasd";
      flake = false;
    };

    fish-ssh-agent = {
      url = "github:danhper/fish-ssh-agent";
      flake = false;
    };

    node2nix.url = "github:samuelludwig/node2nix";
    composer2nix.url = "github:samuelludwig/composer2nix";
    rust-overlay.url = "github:oxalica/rust-overlay";

    php-serenata-language-server = {
      url = "gitlab:Serenata/Serenata";
      flake = false;
    };

    nixGL = {
      url = "github:guibou/nixGL";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware
    , neovim-nightly-overlay, rust-overlay, node2nix, composer2nix
    , copier-pkgs-preview, ... }:
    let
      # Import attrs generated from running the `init-repo.sh` script.
      meta = import ./metaInfo.nix;

      # Utility to let us symlink and un-symlink our non-nix config files on
      # demand.
      linkConfig = config: rec {
        # Set to true to have non-nix configs update as they're changed (i.e.
        # without requiring a rebuild).
        live = true;

        flakeRoot = self.outPath;
        extRoot = meta.repoDir;
        to = path:
          if live then
            config.lib.file.mkOutOfStoreSymlink "${extRoot}/${path}"
          else
            "${flakeRoot}/${path}";
      };

      # Where, relative to the root of the flake, we can access our config
      # modules.
      modPath = {
        user = "modules/user"; # For user-specific configs
        lang = "modules/user/langs"; # For programming-language-specific configs
        system = "modules/system"; # For system-wide configs
        # ^^^^ usually firmware/driver/hardware-related.
      };

      # This (./. + "path") is the only way to get nix to not complain about
      # our string paths not being absolute.
      toMod = type: name: builtins.toPath (./. + "/${modPath.${type}}/${name}");
      toMods = type: modList: map (toMod type) modList;
      uMods = modList: toMods "user" modList;
      langMods = modList: toMods "lang" modList;
      sysMods = modList: toMods "system" modList;

      langModList = langMods [
        "php"
        "python"
        "lua"
        "js"
        "elixir"
        "rust"
        "haskell"
        "unison"
      ];

      # Terminal needs for every machine.
      coreModules = uMods [
        "core"
        "fun"
        "communication"
        "copier"
        "dev-tools"
        "nvim"
        "tmux"
        "tmuxp"
        "bashnonnixos"
        "fish"
        "starship"
        "gitea"
      ] ++ langModList;

      # Currently scuffed sadsad
      telescope-fzf-native-overlay = final: prev: {
        telescope-fzf-native =
          prev.callPackage ./custom/telescope-fzf-native.nix {
            src = inputs.telescope-fzf-native;
          };
      };

      cachixOverlay = system:
        (final: prev: { cachix = inputs.cachix.defaultPackage.${system}; });

      coreOverlays = system: [ (cachixOverlay system) ];
      neovimOverlays =
        [ neovim-nightly-overlay.overlay telescope-fzf-native-overlay ];
      langOverlays = system: [
        rust-overlay.overlay
        composer2nix.overlays.${system}
        node2nix.overlays.${system}
      ];
      developmentOverlays = system: neovimOverlays ++ (langOverlays system);
      overlays = system: (coreOverlays system) ++ (developmentOverlays system);

      #
      # Defaults: change these as you'd like.
      #
      stdUser = meta.username;
      stdTestUser = "${stdUser}-test";

      hmConfDefaults = rec {
        system = "x86_64-linux";
        stateVersion = "21.05";
        extraSpecialArgs = { inherit inputs linkConfig modPath system copier-pkgs-preview; };
        username = meta.username;
        homeDirectory = meta.homeDir;
        configuration = {
          imports = coreModules ++ uMods [ ] ++ sysMods [ ];
          nixpkgs.overlays = (overlays system);
        };
      };

      #
      # We want to actually define our configs with this function.
      #
      mkHMConf = user: attrs:
        home-manager.lib.homeManagerConfiguration (hmConfDefaults // {
          username = user;
          homeDirectory = "/home/${user}";
        } // attrs);

    in {
      homeManagerConfigurations = {

        # My home machine
        garuda-desktop = mkHMConf stdUser rec {
          system = "x86_64-linux";
          configuration = {
            imports = coreModules ++ uMods [ "kittynonnixos" ];
            nixpkgs.overlays = (overlays system) ++ [ ];
          };
        };

        # Linux Server config, no graphical client, but uses nerd-fonts, so
        # whatever terminal you use should support them for the best
        # experience. This can be used anywhere you just want to have your
        # terminal-bound-apps-and-data managed.
        linux-server = mkHMConf stdUser { };

        # The full experience
        nixosdesktop = mkHMConf stdUser {
          configuration.imports = coreModules
            ++ uMods [ "kitty" "discord" "love2d" "bashnixos" "gitgeneral" ];
        };

      };

      # System configurations
      nixosConfigurations = {
        nixosdesktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = sysMods [
            "core"
            "efi-singledrive"
            "generic-sysuser"
            "desktop-hardware-amd-conf"
            "xserver-gnome40"
            "nvidia"
            "amd-cpu"
          ];
        };
      };

    };
}
