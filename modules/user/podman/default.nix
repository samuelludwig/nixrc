{ pkgs, config, lib, linkConfig, modPath, meta, inputs, ... }@args:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.user}/podman/config";
in {
  home.packages = with pkgs; [
    ansible
    buildah
    oci-image-tool
    podman
    podman-compose
    skopeo
  ];

  #
  # Config files
  #
  #xdg.configFile."".source = mkLink.to "${confRoot}/";
}
