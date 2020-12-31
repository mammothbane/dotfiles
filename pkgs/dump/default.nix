{
  writeShellScriptBin,
  postgresql96,
  mongodb-tools,
  ...
}:

with builtins;

let
  fileContents = readFile ./dump;
  substituted = replaceStrings
    ["mongodump" "pg_dump"]
    ["${mongodb-tools}/bin/mongodump" "${postgresql96}/bin/pg_dump"]
    fileContents;

in writeShellScriptBin "dump" substituted

