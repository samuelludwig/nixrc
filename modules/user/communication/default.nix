{ config, pkgs, libs, ... }: 
let
  wcs = pkgs.weechatScripts;
in
{
  home.packages = with pkgs; [
    # CLI
    telegram-cli

    # Weechat
    weechat
    wcs.weechat-matrix
    wcs.colorize_nicks
    wcs.edit

    matrix-commander
  ];
}
