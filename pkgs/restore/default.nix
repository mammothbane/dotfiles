{ pkgs, ... }:

let
  fileContents = builtins.readFile ./restore;
  substituted = builtins.replaceStrings
    ["mongorestore" "pg_restore" "psql"]
    [
      "${pkgs.mongodb-tools}/bin/mongorestore" 
      "${pkgs.postgresql96}/bin/pg_restore"
      "${pkgs.postgresql96}/bin/psql"
    ]
    fileContents;

in pkgs.writeShellScriptBin "restore" substituted

