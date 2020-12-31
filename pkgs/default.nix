{ pkgs, ... }:

with pkgs; {
  tulip = {
    dump    = callPackage ./dump {};
    restore = callPackage ./restore {};
  };
}
