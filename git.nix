{ pkgs, ... }:
{
  enable = true;
  userName = "Nathan Perry";
  userEmail = "np@nathanperry.dev";

  lfs.enable = true;

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

    g     = "graph";
    graph = "log --graph  --decorate --all --date-order --pretty=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";

    yolo = "!git commit -m \"$(${pkgs.curl}/bin/curl -s whatthecommit.com/index.txt)\"";
  };

  signing = {
    key = "2E4DE058CFDBB6F4";
    signByDefault = true;
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
  };
}
