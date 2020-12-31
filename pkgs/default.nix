{
  callPackage,
  ...
}:

{
  tulip = {
    dump    = callPackage ./dump {};
    restore = callPackage ./restore {};
  };
}
