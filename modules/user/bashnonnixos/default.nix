{ pkgs, config, lib, linkConfig, modPath, ...}:
{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      . ~/.oldbashrc
      alias n="nvim -O"
    '';
    profileExtra = ''
      export XDG_DATA_DIRS=$HOME/.nix-profile/share''${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS
      # export LIBGL_ALWAYS_INDIRECT=1
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
          . $HOME/.nix-profile/etc/profile.d/nix.sh;
      fi

      exec fish
    '';
  };
}
