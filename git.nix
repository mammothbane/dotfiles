{ pkgs, ... }:

let
  setsign = pkgs.writeScript "setsign" ''
    #!${pkgs.python3}/bin/python3

    from configparser import ConfigParser
    from pathlib import Path
    import sys

    CONFIG_PATH = Path.home() / '.gitconfig_local'

    parser = ConfigParser()
    parser.read(CONFIG_PATH)

    if not parser.has_section('commit'):
        parser.add_section('commit')

    if parser['commit'].get('gpgsign') == sys.argv[1]:
        sys.exit(0)

    parser['commit']['gpgsign'] = sys.argv[1]

    with open(CONFIG_PATH, 'w') as f:
        parser.write(f)
  '';

in {
  programs.git = {
    enable = true;
    userName = "Nathan Perry";
    userEmail = "np@nathanperry.dev";

    lfs.enable = true;

    delta = {
      enable = true;

      options = {
        features = "decorations line-numbers side-by-side";
        syntax-theme = "OneHalfDark";
        decorations = {
          file-style = "bold yellow ul";
          file-decoration-style = "none";
          commit-decoration-style = "bold yellow box ul";
        };
      };
    };

    aliases = {
      co = "checkout";

      c = "commit";
      amend = "commit --amend --no-edit";
      s = "status";

      nosign = "ns";
      ns = "!git -c commit.gpgsign=false";

      prune = "remote prune origin";
      p = "remote prune origin";

      b = "branch";
      bd = "branch -d";
      bn = "rev-parse --abbrev-ref HEAD";
      bs = "!bname=\"$(git bn)\" && git branch --set-upstream-to=origin/$bname $bname";
      tracked = "!git rev-parse --abbrev-ref --symbolic-full-name @{u} > /dev/null 2>&1";

      detach = "!git checkout $(git rev-parse HEAD)";

      g     = "graph";
      graph = "log --graph  --decorate --all --date-order --pretty=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";

      yolo = "!git commit -m \"$(${pkgs.curl}/bin/curl -s whatthecommit.com/index.txt)\"";

      enable-signing = "!${setsign} true";
      disable-signing = "!${setsign} false";
    };

    signing = {
      key = "2E4DE058CFDBB6F4";
      signByDefault = false;
    };

    ignores = [
      "*~"
      "*.iml"
      ".idea"
      "*.log"
      ".ensime"
      ".ensime_cache"
      ".DS_Store"
      "*.swp"
    ];

    extraConfig = {
      rerere.enabled = true;
      include.path = "~/.gitconfig_local";
      core.coreautocrlf = "input";
      push.default = "current";
      pull.rebase = true;
      credential.helper = "cache";

      advice = {
        detachedHead = false;
        addEmptyPathspec = false;
      };
    };
  };
}
