{ config, pkgs, ... }:

let
  aliases = ''
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'

    alias xclip='xclip -selection c'
    alias rs="exec -l $SHELL"
  '';
in
{
  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "19.09";
    packages = with pkgs; [
      jq
      ripgrep
      xclip
      iotop

      curl
      socat
      wget
      youtube-dl
      nmap

      # discord

      # download not working
      # minecraft

      glibcLocales

      python3
      python3.pkgs.pynvim
      python3.pkgs.pip

      # yubikey-personalization
      # yubioath-desktop
    ];
    sessionVariables = {
      GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
      EDITOR = "vim";
      VISUAL = "vim";
      KEYTIMEOUT = 1;
      NIX_PATH = "$HOME/.nix-defexpr/channels:$NIX_PATH";
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

      PATH = "$PATH:$HOME/bin";
    };
  };

  news.display = "silent";

  programs = {
    home-manager.enable = true;
    vim = import ./vim.nix { inherit pkgs; };
    git = import ./git.nix { inherit pkgs; };

    direnv = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    command-not-found.enable = true;

    broot = {
      enable = true;

      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    bash = {
      enable = true;

      sessionVariables = {
      };

      initExtra = aliases;
    };

    go = {
      enable = true;
      goPath = "src/go";
    };

    htop = {
      enable = true;
      delay = 2;
      hideThreads = true;
      hideUserlandThreads = true;
      highlightBaseName = true;
    };

    keychain = {
      enable = false;
      agents = [
        "gpg"
        "ssh"
      ];
      inheritType = "any";
      extraFlags = [
        "--gpg2"
        "--systemd"
      ];
    };

    lesspipe.enable = true;

    readline = {
      enable = true;
      variables = {
        editing-mode = "vi";
        show-mode-in-prompt = true;
      };
    };

    ssh = {
      enable = true;
      controlMaster = "auto";
      controlPersist = "10m";
      forwardAgent = true;

      matchBlocks = {
        "somali-derp.com" = {
          user = "mammothbane";
        };

        "deploy.bulb.cloud" = {
          user = "ubuntu";
          proxyJump = "vpn.tulip.co";
        };

        "deploy.tulip.co" = {
          user = "ubuntu";
          proxyJump = "vpn.tulip.co";
        };
      };

      extraConfig = ''
      '';
    };

    tmux = {
      enable = true;
      keyMode = "vi";

      extraConfig = ''
        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"

        bind-key -n C-S-Left swap-window -t -1
        bind-key -n C-S-Right swap-window -t +1
      '';

      tmuxp.enable = true;
    };

    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      sessionVariables = {
        MODE_INDICATOR = "%{$fg_bold[yellow]%}[% NORMAL]% %{$reset_color%}";
      };

      initExtra = aliases + ''
      '';

      profileExtra = ''
      '';

      loginExtra = ''
      '';

      logoutExtra = ''
      '';

      oh-my-zsh = {
        enable = true;

        plugins = [
          "gitfast"
          "vi-mode"
          "sudo"
        ];

        theme = "robbyrussell";
      };
    };

    # TODO
    irssi = {};
    # kitty = {};
    notmuch = {};
    # obs-studio = {};
    starship = {};
  };

  services = {
    gpg-agent = {
      enable = true;
      # enableExtraSocket = true;
      enableSshSupport = true;
      enableScDaemon = true;
      defaultCacheTtl = 60;
      maxCacheTtl = 120;

      # TODO(unstable)
      extraConfig = ''
        pinentry-program ${pkgs.pinentry}/bin/pinentry-curses
      '';
    };

    keybase.enable = true;
    lorri.enable = true;
    # spotifyd.enable = true;

    # TODO(unstable)
    # lieer = {};
    muchsync = {};
    polybar = {};
    random-background = {};
  };

  systemd.user = {
    paths = {
    };

    services = {
    };

    sessionVariables = {
      # TODO: SSH_AUTH_SOCK?
    };

    startServices = true;
  };
}
