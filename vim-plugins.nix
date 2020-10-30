plugins:

self: super: let
  regularPlugins = [
    "darcula"

    "vim-mix-format"

    "ncm2-go"
    "ncm2-racer"
    "ncm2-alchemist"
    "ncm2-vim"
    "ncm2-pyclang"
    "ncm2-tern"
  ];

  normalPlugin = name: {
    "${name}" = super.vimUtils.buildVimPlugin {
      inherit name;
      src = plugins."${name}";
    };
  };

  irregularPlugins = {
    ncm2-typescript = {
      name = "ncm2-typescript";
      src = "${plugins.ncm2-typescript}/ncm2-plugin";
    };
  };

in {
  customVimPlugins = builtins.foldl' (acc: x: acc // (normalPlugin x)) irregularPlugins regularPlugins;
}
