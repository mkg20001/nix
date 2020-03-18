lib:

with builtins;
with lib;
let
  _safePath = path: if (tryEval (toPath path)).success then (toPath path) else "/null";
  privFolder = _safePath "/home/maciej/.private.d/nix";

  pWrap = wFnc: file: wFnc "${privFolder}/${file}";
in
rec {
  _withPriv = file: fnc:
    if (pathExists file) then (fnc (loadFile file)) else {};
  _loadPriv = file:
    if (pathExists file) then (loadFile file) else {};

  loadFile = file:
    let
      type = getType file;
      content = readFile file;
    in
      if type == "toml" then
        fromTOML content
      else if type == "json" then
        fromJSON content
      else throw "Not supported type ${type}";
  getType = name: # todo ^.+((\.[a-z0-9]{1,3})(\.[a-z0-9]{1,4}))$
    (elemAt (match "^.+(\\.([a-z0-9]{1,4}))$" (baseNameOf name)) 1);

  loadPriv = pWrap _loadPriv;
  withPriv = pWrap _withPriv;

} // lib // builtins
