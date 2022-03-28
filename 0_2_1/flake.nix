{
  description = ''A minimalistic connection pooling package for sqlite'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-tinypool-0_2_1.flake = false;
  inputs.src-tinypool-0_2_1.ref   = "refs/tags/0.2.1";
  inputs.src-tinypool-0_2_1.owner = "PhilippMDoerner";
  inputs.src-tinypool-0_2_1.repo  = "TinyPool";
  inputs.src-tinypool-0_2_1.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-tinypool-0_2_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-tinypool-0_2_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}