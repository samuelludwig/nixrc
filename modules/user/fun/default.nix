{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    # CLI
    cbonsai
    neofetch
    #spotify-tui
    pipes-rs
    tuir # Reddit tui
    tut # Mastodon tui
  ];
}
