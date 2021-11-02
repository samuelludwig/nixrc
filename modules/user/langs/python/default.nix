{ config, pkgs, libs, inputs, ... }: {
  home.packages = [ pkgs.python3Full ]
    ++ (with pkgs.python39Packages; [ pipx ]);
}
