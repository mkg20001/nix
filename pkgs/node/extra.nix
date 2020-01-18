pkgs:

{
  ndb = {
    buildInputs = [
      pkgs.chromium
      pkgs.makeWrapper
    ];

    installPhase = ''
      sed "s|/usr/share/applications|${pkgs.chromium}/share/applications|g" -i ./node_modules/carlo/lib/find_chrome.js
      wrapProgram $out/node_modules/.bin/ndb \
        --prefix PATH : "${pkgs.chromium}/bin" \
        --set CHROME_PATH "${pkgs.chromium}/bin/chromium"
    '';
  };
}
