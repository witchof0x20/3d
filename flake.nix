{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs) {
          inherit system;
        };
      in
      {
        packages.flexatx = pkgs.callPackage ./10rack/flexatx { };
        packages.hdd = pkgs.callPackage ./10rack/hdd { };

        devShell = pkgs.mkShell {
          packages = with pkgs; [ openscad ];
        };
      }
    );
}
