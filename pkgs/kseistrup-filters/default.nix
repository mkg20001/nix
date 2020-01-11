{ stdenv
, fetchFromGitHub
, gawk
}:

stdenv.mkDerivation {
  pname = "kseistrup-filters";
  version = "12-01-2012";

  src = fetchFromGitHub {
    repo = "filters";
    owner = "kseistrup";
    rev = "1e4e2bbc77ebfd7896356853259f986f75e13156";
    sha256 = "05b2lr5m563s4i1q77jldxs5x2bfff56qxdxgsjjz53wxm931gi4";
  };

  buildInputs = [
    gawk
  ];

  installPhase = ''
    sed "s|env -S|env|g" -i bin/*.awk
    mkdir $out
    cp -rp {bin,doc,man} $out
  '';
}
