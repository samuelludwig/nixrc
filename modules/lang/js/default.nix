{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [ nodejs node2nix ];

  programs.bash = {
    bashrcExtra = ''
      export PATH=$PATH:~/.npm/bin
    '';
  };

  programs.fish.shellInit = ''
    set -gx PATH $PATH:~/.npm/bin
  '';
}
