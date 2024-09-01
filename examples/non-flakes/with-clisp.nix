{ pkgs ? import <nixpkgs> { } }:

let
  lispBuilder = import ../.. { };
  inherit (lispBuilder) buildASDF;
  fetchFromGitLab = pkgs.fetchFromGitLab;
in

buildASDF rec {
  lisp = pkgs.clisp;
  pname = "alexandria";
  version = "1.4";
  src = fetchFromGitLab {
    domain = "gitlab.common-lisp.net";
    owner = "alexandria";
    repo = "alexandria";
    rev = "v${version}";
    hash = "sha256-1Hzxt65dZvgOFIljjjlSGgKYkj+YBLwJCACi5DZsKmQ=";
  };
}
