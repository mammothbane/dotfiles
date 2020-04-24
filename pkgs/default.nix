{ pkgs, ... }:

{
  tulip = {
    dump    = pkgs.callPackage ./dump {};
    restore = pkgs.callPackage ./restore {};
  };
}
