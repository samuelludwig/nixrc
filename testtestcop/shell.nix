{ pkgs, devPackage }:
pkgs.mkShell {
  name = "pleaseGod-devShell";
  packages = with pkgs; [ devPackage ];
  inputsFrom = [ devPackage ];

  nativeBuildInputs = with pkgs; [
      # hello cowsay
  ];
}

