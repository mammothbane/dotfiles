{
  writeShellScriptBin,
  postgresql96,
  mongodb-tools,
  ...
}:

with builtins;

let
  fileContents = readFile ./restore;
  substituted = replaceStrings
    ["mongorestore" "pg_restore" "psql"]
    [
      "${mongodb-tools}/bin/mongorestore"
      "${postgresql96}/bin/pg_restore"
      "${postgresql96}/bin/psql"
    ]
    fileContents;

in writeShellScriptBin "restore" substituted


