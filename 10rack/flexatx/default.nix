{ stdenvNoCC, openscad }:

stdenvNoCC.mkDerivation {
  pname = "flexatx-rack-mount";
  version = "0.1.0";
  src = ./.;

  nativeBuildInputs = [ openscad ];

  buildPhase = ''
    runHook preBuild
    for part in body clamp; do
      openscad -o "flexatx_$part.stl" -D "part=\"$part\"" flexatx_mount.scad
    done
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 -t $out flexatx_*.stl
    runHook postInstall
  '';
}
