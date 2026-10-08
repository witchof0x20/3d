{ stdenvNoCC, openscad }:

stdenvNoCC.mkDerivation {
  pname = "hdd-rack-insert";
  version = "0.1.0";
  src = ./.;

  nativeBuildInputs = [ openscad ];

  buildPhase = ''
    runHook preBuild
    for part in plate caddy backplane fan_panel brace_left brace_right test_ear; do
      openscad -o "hdd_$part.stl" -D "part=\"$part\"" hdd_cage.scad
    done
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 -t $out hdd_*.stl
    runHook postInstall
  '';
}
