{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = { self, nixpkgs, flake-utils, treefmt-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in
      {
        lispBuilder = import ./default.nix { };

        formatter = treefmtEval.config.build.wrapper;

        checks = {
          formatting = treefmtEval.config.build.check self;
          non-flakes-clisp = pkgs.callPackage ./examples/non-flakes/with-clisp.nix { };
          non-flakes-sbcl = pkgs.callPackage ./examples/non-flakes/with-sbcl.nix { };
        };

        devShells.default = pkgs.mkShell {
          packages = [
            # Common Lisp REPL
            pkgs.sbcl

            # for Nix
            pkgs.nil
            pkgs.nixpkgs-fmt
          ];
        };
      });
}
