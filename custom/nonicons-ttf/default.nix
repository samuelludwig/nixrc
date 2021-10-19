{ lib, fetchzip }:

let
  version = "master";
in fetchzip {
  name = "nonicons-${version}";

  url = "https://github.com/yamatsum/nonicons/archive/refs/heads/master.zip";

  postFetch = ''
    mkdir -p $out/share/fonts
    unzip -j $downloadedFile \*.ttf -d $out/share/fonts/truetype
  '';

  sha256 = "sha256-wPW4+cv+u0Qr5eV3WIP2skJVQR24ppjkrWugOTeWy8k=";

  meta = {
    description = "A set of SVG icons representing programming languages, designing & development tools";
    homepage = "https://github.com/yamatsum/nonicons";
    meta.license = lib.licenses.unfree;
  };
}
