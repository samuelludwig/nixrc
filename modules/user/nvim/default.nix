{ pkgs, config, lib, linkConfig, modPath, inputs, ... }@args:
let
  mkLink = linkConfig config;
  ts = pkgs.tree-sitter.builtGrammars;
  confRoot = "${modPath.user}/nvim";

  # Not currently working :(
  #phpLS = { name = "php-serenata-language-server"; src = inputs.php-serenata-language-server; };
  phpLS = (pkgs.callPackage ./intelephense { inherit pkgs; }).intelephense;

  languageServers = with pkgs; [
    nodePackages.typescript-language-server
    nodePackages.eslint_d
    nodePackages.prettier
    nodePackages.yaml-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.pyright
    rnix-lsp
    sumneko-lua-language-server
    haskell-language-server
    phpLS
  ];

  formatters = with pkgs; [
    fzf
    php80Packages.phpcbf
    ormolu
    tree-sitter
    stylua
    nixfmt
    black
    python39Packages.isort
    fd
    neovim-remote
  ];

  # (xdg.configFile's)
  treesitterParsers = {
    "nvim/parser/c.so".source = "${ts.tree-sitter-c}/parser";
    "nvim/parser/lua.so".source = "${ts.tree-sitter-lua}/parser";
    "nvim/parser/rust.so".source = "${ts.tree-sitter-rust}/parser";
    "nvim/parser/python.so".source = "${ts.tree-sitter-python}/parser";
    "nvim/parser/typescript.so".source = "${ts.tree-sitter-typescript}/parser";
    "nvim/parser/javascript.so".source = "${ts.tree-sitter-javascript}/parser";
    "nvim/parser/tsx.so".source = "${ts.tree-sitter-tsx}/parser";
    "nvim/parser/nix.so".source = "${ts.tree-sitter-nix}/parser";
    "nvim/parser/yaml.so".source = "${ts.tree-sitter-yaml}/parser";
    "nvim/parser/bash.so".source = "${ts.tree-sitter-bash}/parser";
    "nvim/parser/comment.so".source = "${ts.tree-sitter-comment}/parser";
    "nvim/parser/php.so".source = "${ts.tree-sitter-php}/parser";
    "nvim/parser/haskell.so".source = "${ts.tree-sitter-haskell}/parser";
  };

in {
  #
  # Shell configurations
  #
  programs.bash = {
    bashrcExtra = ''
      export EDITOR="nvim"
      alias n="nvim -O"
    '';
  };

  programs.fish = {
    shellAliases.n = "nvim -O";
    shellAliases.sc = ''
      git -C ~/vimwiki pull && git -C ~/vimwiki add . && \
        git -C ~/vimwiki commit -m 'Update Core'&& git -C ~/vimwiki push -u \
    '';
    shellInit = ''
      set -gx EDITOR nvim
    '';
  };

  home.packages = with pkgs; [ ] ++ formatters ++ languageServers;

  # Required for lang-servers
  home.file.".npmrc".text = ''
    prefix=~/.npm
  '';

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraConfig = ''
      lua require('dot')
    '';
  };

  # Do the requisite black magic for telescope-fzf
  xdg.dataFile."nvim/site/pack/packer/start/telescope-fzf-native.nvim/build/libfzf.so".source =
    "${pkgs.telescope-fzf-native}/build/libfzf.so";

  #
  # Acutal config files
  #
  xdg.configFile = {
    "nvim/lua/dot".source = mkLink.to "${confRoot}/lua/dot";
    "nvim/ftplugin/markdown.vim".source =
      mkLink.to "${confRoot}/ftpludin/markdown.vim";
  } // treesitterParsers;
}
