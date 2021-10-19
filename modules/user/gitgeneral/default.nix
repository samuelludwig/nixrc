{ pkgs, config, lib, ...}:
{
  programs.git = {
    enable = true;
    userName  = "samuelludwig";
    userEmail = "SLudwig.dev@gmail.com";
  };
}
