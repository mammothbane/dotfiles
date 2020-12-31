{
  pkgs,
  lib,
  config,
  localConfigFile ? ./local.nix,
  ...
}:

{
  imports = [
    ./git.nix
    ./vim.nix
    ./shells.nix
    ./graphical.nix
    ./packages.nix
    ./fs.nix
  ];

  options = with lib; {
    pinentry = mkOption {
      description = "pinentry program";
      type = types.package;
      default = pkgs.pinentry;
    };
  };

  config = {
    home = {
      stateVersion = "20.09";

      sessionVariables = {
        GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
        EDITOR = "nvim";
        VISUAL = "nvim";
        KEYTIMEOUT = 1;
        LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
        PATH = "$HOME/.nix-profile/bin:$HOME/.nix-profile/sbin";
        PAGER = "${pkgs.less}/bin/less";
      };
    };

    news.display = "silent";

    programs = {
      broot = {
        enable = true;

        enableZshIntegration = true;
        enableBashIntegration = true;
      };

      go = {
        enable = true;
        goPath = "src/go";
      };

      htop = {
        enable = true;
        delay = 6;
        hideThreads = true;
        hideUserlandThreads = true;
        highlightBaseName = true;
      };

      lesspipe.enable = true;

      # TODO
      irssi = {};
      notmuch = {};
      starship = {};
    };

    services = {
      gpg-agent = {
        enable = true;
        enableExtraSocket = true;
        enableSshSupport = true;
        enableScDaemon = true;
        defaultCacheTtl = 60;
        maxCacheTtl = 120;

        extraConfig = ''
          pinentry-program ${config.pinentry}/bin/pinentry
        '';
      };

      keybase.enable = true;
      lorri.enable = true;

      spotifyd.enable = true;

      # TODO(unstable)
      # lieer = {};
      muchsync = {};
    };

    systemd.user = {
      paths = {
      };

      services = {
      };

      sessionVariables = {
        GSM_SKIP_SSH_AGENT_WORKAROUND = "1";
      };

      startServices = true;
    };
  };
}
