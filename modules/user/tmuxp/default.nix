{ pkgs, config, lib, linkConfig, modPath, ... }: {
  home.packages = [ pkgs.tmuxp ];
  home.programs.tmux.tmuxp.enable = true;
  xdg.configFile."tmuxp".source =
    (linkConfig config).to "${modPath.user}/tmuxp/layouts";
}
