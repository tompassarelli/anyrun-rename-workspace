{
  description = "Anyrun plugin for renaming niri workspaces";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.rustPlatform.buildRustPackage {
            pname = "anyrun-rename-workspace";
            version = "0.1.0";

            src = ./.;

            cargoLock = {
              lockFile = ./Cargo.lock;
              outputHashes = {
                "anyrun-interface-25.9.3" = "sha256-ynLb+3Y+sbrNc2HD1VTRNBj2GKm44CGENTJZwvn0Xt0=";
                "anyrun-macros-25.9.3" = "sha256-GLGdVJSPH0LnsO64Biw0WFJaj1PlltYxgH13f+FGWgQ=";
              };
            };

            installPhase = ''
              mkdir -p $out/lib
              cp target/release/libanyrun_rename_workspace.so $out/lib/
            '';
          };
        }
      );
    };
}
