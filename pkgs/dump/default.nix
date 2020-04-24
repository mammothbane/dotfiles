{ pkgs, ... }:

let
  fileContents = builtins.readFile ./dump;
  substituted = builtins.replaceStrings
    ["mongodump" "pg_dump"]
    ["${pkgs.mongodb-tools}/bin/mongodump" "${pkgs.postgresql96}/bin/pg_dump"]
    fileContents;

in pkgs.writeShellScriptBin "dump" substituted

