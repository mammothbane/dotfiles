{ pkgs, ... }:

rec {
  setuidWrapper = pkgs.callPackage ./setuid_wrapper.nix {};
  wrapSetuids = binaries: pkgs.lib.lists.map setuidWrapper binaries;

  tulip = {
    dump    = pkgs.callPackage ./dump {};
    restore = pkgs.callPackage ./restore {};
  };
}
