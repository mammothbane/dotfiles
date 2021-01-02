{ config, pkgs, lib, ... }:

let
  nvim = "${config.programs.neovim.package}/bin/nvim";

in {
  home.sessionVariables = {
    GCC_COLORS      = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
    EDITOR          = nvim;
    VISUAL          = nvim;
    KEYTIMEOUT      = 1;
    LOCALE_ARCHIVE  = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    PATH            = "$HOME/.nix-profile/bin:$HOME/.nix-profile/sbin";
    PAGER           = "${pkgs.less}/bin/less";


    FLAKE_TMPL        = "https://gist.githubusercontent.com/mammothbane/f44a1ebdde8d0198bf30073e145e7533/raw/flake.nix";
    EDITORCONFIG_TMPL = "https://gist.githubusercontent.com/mammothbane/24ff5cd0111b687009062df83930c65c/raw/.editorconfig";
  };

  systemd.user.sessionVariables = {
    GSM_SKIP_SSH_AGENT_WORKAROUND = "1";
  };
}
