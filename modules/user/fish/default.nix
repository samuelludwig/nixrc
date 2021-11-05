{ pkgs, config, lib, inputs, linkConfig, modPath, ... }:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.user}/fish";
in {
  home.packages = [ pkgs.fasd ];

  programs.fish = {
    enable = true;

    shellAliases = {
      gs = "lazygit";
      ".." = "cd ..";
      "..." = "cd ../..";
      nf = "nix flake";
      nb = "nix build";
      re = "nix repl";
    };

    plugins = [
      {
        name = "fasd";
        src = inputs.fish-fasd;
      }
      {
        name = "fish-ssh-agent";
        src = inputs.fish-ssh-agent;
      }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
          sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
        };
      }
    ];

    #shellInit = ''
    #  source config.fish
    #'';
  };

  #xdg.configFile."fish".source = mkLink.to "${confRoot}/";
}
