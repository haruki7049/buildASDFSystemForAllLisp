{ }:

{
  buildASDF =
    { lisp
    , pname
    , version
    , src
    }:
    lisp.buildASDFSystem {
      inherit pname version;
      inherit src;
    };
}
