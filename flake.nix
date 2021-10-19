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
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware
    , neovim-nightly-overlay, ... }:
    let
      # These values need to be set to be in line with where the flake exists
      # on the host filesystem if you want to use live-updating configs.
      # `pathFromHome` must be defined *relative to* the invoking user's home
      # directory.
      repoDir = rec { name = "nixrc"; pathFromHome = "${name}"; };

      # Utility to let us symlink and un-symlink our non-nix config files on
      # demand.
      linkConfig = config: rec {
        # Set to true to have non-nix configs update as they're changed (i.e.
        # without requiring a rebuild).
        live = false;

        flakeRoot = self.outPath;
        extRoot = "${config.home.homeDirectory}/${repoDir.pathFromHome}";
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
        system = "modules/system"; # For system-wide configs
        # ^^^^ usually firmware/driver/hardware-related.
      };

      # Currently scuffed sadsad
      telescope-fzf-native-overlay = final: prev: {
        telescope-fzf-native =
          prev.callPackage ./custom/telescope-fzf-native.nix {
            src = inputs.telescope-fzf-native;
          };
      };

      neovimOverlays =
        [ neovim-nightly-overlay.overlay telescope-fzf-native-overlay ];

      # This (./. + "path") is the only way to get nix to not complain about
      # our string paths not being absolute.
      toMod = type: name: builtins.toPath (./. + "/${modPath.${type}}/${name}");
      toMods = type: modList: map (toMod type) modList;
      uMods = modList: toMods "user" modList;
      sysMods = modList: toMods "system" modList;

      coreModules =
        uMods [ "core" "nvim" "tmux" "bashnonnixos" "fish" "starship" ];

      #
      # Defaults: change these as you'd like.
      #
      defaultUser = "dot";
      defaultTestUser = "dottest";

      hmConfDefaults = rec {
        system = "x86_64-linux";
        stateVersion = "21.05";
        extraSpecialArgs = { inherit inputs linkConfig modPath; };
        username = defaultUser;
        homeDirectory = "/home/${username}";
        configuration = {
          imports = coreModules ++ [ ];
          nixpkgs.overlays = neovimOverlays ++ [ ];
        };
      };

      mkHMConf = user: attrs:
        home-manager.lib.homeManagerConfiguration (hmConfDefaults // {
          username = user;
          homeDirectory = "/home/${user}";
        } // attrs);

    in {
      homeManagerConfigurations = {

        # My home machine
        garuda-desktop = mkHMConf defaultUser {
          configuration.imports = coreModules ++ uMods [ "kittynonnixos" ];
        };

        # Linux Server config, no graphical client, but uses nerd-fonts, so
        # whatever terminal you use should support them for the best
        # experience.
        linux-server = mkHMConf defaultUser { };

        # The full experience
        nixosdesktop = mkHMConf defaultUser {
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
