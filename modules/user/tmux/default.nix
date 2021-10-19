{ pkgs, config, lib, linkConfig, modPath, ... }: {
  home.file.".tmux.conf".source =
    (linkConfig config).to "${modPath.user}/tmux/.tmux.conf";
}
