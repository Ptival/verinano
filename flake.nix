{
  description = "My Idris 2 package";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.idris2-pkgs.url = "github:claymager/idris2-pkgs";

  outputs = { self, nixpkgs, idris2-pkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-darwin" "x86_64-linux" "i686-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ idris2-pkgs.overlay ]; };
        verinano = pkgs.idris2.buildTOMLSource ./. ./verinano.toml;
      in
      {
        defaultPackage = verinano;

        devShell =
          let withDeps = base: base.withPackages (p: verinano.idrisLibraries ++ verinano.idrisTestLibraries);
          in
          pkgs.mkShell {
            buildInputs = map withDeps [
              pkgs.idris2
              pkgs.idris2.packages.lsp
            ];
          };
      }
    );
}
