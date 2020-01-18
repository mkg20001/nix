pkgs:

{
  ndb = {
    postInstallPhases = [ "wrapNdb" ];

    buildInputs = [
      pkgs.chromium
      pkgs.makeWrapper
    ];

    wrapNdb = ''
      wrapProgram $out/node_modules/.bin/ndb \
        --prefix PATH : "${pkgs.chromium}/bin"
    '';
  };
}
