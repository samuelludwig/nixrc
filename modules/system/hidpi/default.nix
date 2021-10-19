{ config, lib, pkgs, ... }: {
  # services.xserver.dpi = 180;

  # environment.variables = {
  #   GDK_SCALE = "2";
  #   GDK_DPI_SCALE = "0.5";
  #   _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  # };

  hardware.video.hidpi.enable = true;
}
