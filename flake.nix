{
  description = "Flake for development of the Fogent Roleplay Rules";

  outputs = { self, nixpkgs }:

    let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    in {
      packages.${system} = {

        default = pkgs.writeShellScriptBin "run" ''
          nix develop -c -- codium .
        '';
        
        test = pkgs.writeShellScriptBin "fa" ''

          ${pkgs.figlet}/bin/figlet "Fallen is awesome!"
        '';

      };
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [ 
          (vscode-with-extensions.override {
            vscode = pkgs.vscodium;
            vscodeExtensions = with pkgs.vscode-extensions; [
              jnoortheen.nix-ide
              yzhang.markdown-all-in-one
              mhutchie.git-graph
              streetsidesoftware.code-spell-checker
              #vscodevim.vim
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
              {
                name = "vscode-office";
                publisher = "cweijan";
                version = "3.2.5";
                sha256 = "sha256-TsPlzIf/ieUW/13NQ0strDQTVFvwtrO48fJSUbMu1Bc=";
              }
              {
                name = "vscode-edit-csv";
                publisher = "janisdd";
                version = "0.8.2";
                sha256 = "sha256-DbAGQnizAzvpITtPwG4BHflUwBUrmOWCO7hRDOr/YWQ=";
              }
            ];
          })
        ];

      };
    };
}
