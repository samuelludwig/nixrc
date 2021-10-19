{ config, pkgs, ... }: {
  services.xserver.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako # notification daemon
      dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
    ];
  };

  # brightness keys support
  environment.systemPackages = with pkgs; [ 
    brightnessctl
  ];

  fonts.fonts = with pkgs; [
    font-awesome
  ];

  networking.networkmanager.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
