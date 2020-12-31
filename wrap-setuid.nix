{ pkgs, ... }:

let
  setuidWrapper = pkgs.writeShellScript "wrap_setuid" ''
    # this is heuristic, but it will definitely do the trick on nixos, and should work
    # for most reasonable distros
    binaryName=$1
    shift

    binary=$(PATH=/run/wrappers/bin:/usr/local/bin:/usr/bin:/bin:/sbin command -v $binaryName)

    if [ -z "$binary" ]; then
      echo "home-manager setuid wrapper couldn't find real $binaryName on your system" >&2
      exit 1
    fi

    me=$("${pkgs.coreutils}/bin/realpath" "''${BASH_SOURCE[0]}")
    realbinary=$("${pkgs.coreutils}/bin/realpath" "$binary")

    if [ "$me" == "$realbinary" ]; then
      echo "home-manager setuid found a cycle" >&2
      exit 1
    fi

    exec "$binary" "$@"
  '';

  wrapSetuid = binaryName: pkgs.writeShellScriptBin binaryName ''exec "${setuidWrapper}" "${binaryName}" "$@"'';

in {
  home.packages = map wrapSetuid [
    "sudo"
    "sudoedit"
    "su"
    "passwd"
    "newgrp"
    "newuidmap"
    "newgidmap"
    "sg"
    "start_kdeinit"
    "unix_chkpwd"
    "kcheckpass"
    "fusermount"
    "fusermount3"
    "dbus-daemon-launch-helper"
  ];
}
