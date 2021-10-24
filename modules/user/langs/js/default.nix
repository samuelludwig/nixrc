{ config, pkgs, libs, ... }: {
  home.packages = [ pkgs.nodejs ];

  programs.bash = {
    bashrcExtra = ''
      export PATH=$PATH:~/.npm/bin
    '';
  };

  programs.fish.shellInit = ''
    set -gx PATH $PATH:~/.npm/bin
  '';
}
