{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    # CLI
    telegram-cli
    weechat
    weechatScripts.weechat-matrix
    matrix-commander
  ];
}
