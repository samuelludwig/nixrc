{ pkgs ? import <nixpkgs> { }, stdenv ? pkgs.stdenv, lib ? pkgs.lib
, fetchurl ? pkgs.fetchurl, p7zip ? pkgs.p7zip }:

stdenv.mkDerivation {
  name = "otf-apple";
  version = "1.0";

  buildInputs = [ p7zip ];

  src = [
    (fetchurl {
      url =
        "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
      sha256 = "sha256-P69DHx/V0NoDcI6jrZdlhbpjrdHo8DEGT+2yg5jYw/M=";
    })
    (fetchurl {
      url =
        "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
      sha256 =
        "ec0518e310797d2f9cb924c18e3e7b661359f4fb653d1ad4315758ebcdb5ff11";
    })
    (fetchurl {
      url =
        "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
      sha256 = "sha256-U3F91nQki5W1vpb7Yitvr3mPK7b5eyqkGv8iJynVdPI=";
    })
    (fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
      sha256 = "sha256-5Er6Aux1rGgApQ6RZEb4xaPtBC+jzYRq5YYMmbU387I=";
    })
  ];

  sourceRoot = "./";

  preUnpack = "mkdir fonts";

  unpackCmd = ''
    7z x $curSrc >/dev/null
    dir="$(find . -not \( -path ./fonts -prune \) -type d | sed -n 2p)"
    cd $dir 2>/dev/null
    7z x *.pkg >/dev/null
    7z x Payload~ >/dev/null
    mv Library/Fonts/*.otf ../fonts/
    cd ../
    rm -R $dir
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/opentype/{SF\ Pro,SF\ Mono,SF\ Compact,New\ York}
    cp -a fonts/SF-Pro*.otf $out/share/fonts/opentype/SF\ Pro
    cp -a fonts/SF-Mono*.otf $out/share/fonts/opentype/SF\ Mono
    cp -a fonts/SF-Compact*.otf $out/share/fonts/opentype/SF\ Compact
    cp -a fonts/NewYork*.otf $out/share/fonts/opentype/New\ York
  '';
}
