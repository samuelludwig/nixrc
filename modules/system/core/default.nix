{ config, pkgs, lib, ...}:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      substituters = https://cache.nixos.org https://nix-community.cachix.org
      trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
    '';
    package = pkgs.nixFlakes;
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    NIXPKGS_ALLOW_UNFREE="1";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "America/New_York";

  services.earlyoom.enable = true;

  services.openssh.enable = true;

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    vim
    firefox
    dropbox
    # scripts.sysTool
  ];

  system.stateVersion = "21.05";
}

