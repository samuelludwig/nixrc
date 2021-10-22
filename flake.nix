{
  description = "System & home configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    , neovim-nightly-overlay, ... }:
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

      # Terminal needs for every machine.
      coreModules =
        uMods [ "core" "nvim" "tmux" "tmuxp" "bashnonnixos" "fish" "starship" ]
        ++ langMods [ "php" ];

      # Currently scuffed sadsad
      telescope-fzf-native-overlay = final: prev: {
        telescope-fzf-native =
          prev.callPackage ./custom/telescope-fzf-native.nix {
            src = inputs.telescope-fzf-native;
          };
      };

      neovimOverlays =
        [ neovim-nightly-overlay.overlay telescope-fzf-native-overlay ];

      #
      # Defaults: change these as you'd like.
      #
      stdUser = meta.username;
      stdTestUser = "${stdUser}-test";

      hmConfDefaults = rec {
        system = "x86_64-linux";
        stateVersion = "21.05";
        extraSpecialArgs = { inherit inputs linkConfig modPath; };
        username = meta.username;
        homeDirectory = meta.homeDir;
        configuration = {
          imports = coreModules ++ uMods [ ] ++ sysMods [ ];
          nixpkgs.overlays = neovimOverlays ++ [ ];
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
        garuda-desktop = mkHMConf stdUser {
          configuration = {
            imports = coreModules ++ uMods [ "kittynonnixos" ];
            nixpkgs.overlays = neovimOverlays ++ [ ];
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
