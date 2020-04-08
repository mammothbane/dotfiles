{ pkgs, ... }:
let
  nixpkgsConfig = import ./nixpkgs-config.nix;

  sources = import nix/sources.nix;
  overlay = _: pkgs: {
    niv = import sources.niv {};
  };
  pinnedPkgs = import sources.nixpkgs {
    overlays = [ overlay ];
    config = nixpkgsConfig // {
    };
  };

  aliases = ''
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'

    alias xclip='xclip -selection c'
    alias rs="exec -l $SHELL"

    alias hm=home-manager
  '';

  ownpkgs-root  = pkgs.callPackage sources.ownpkgs {};
  ownpkgs       = ownpkgs-root.pkgs;
  ownlib        = ownpkgs-root.lib;

  localConfig = with ownlib; let
    tryLocal  = tryCallPackage ./local.nix {};
    local     = orDefault tryLocal {};
  in {
    graphical = false;
  } // local;

  pinentry = if localConfig.graphical
    then pinnedPkgs.pinentry-gnome
    else pkgs.pinentry;

  graphicalPackages = with pinnedPkgs; with ownpkgs; [
    discord
    minecraft

    yubikey-personalization
    # yubioath-desktop -- broken
  ];

in
{
  nixpkgs.config = nixpkgsConfig;
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  home = {
    stateVersion = "19.09";
    packages = with pkgs; with ownpkgs; [
      jq
      ripgrep
      xclip
      iotop
      curl
      socat
      wget
      youtube-dl
      nmap

      haskellPackages.niv
      cordless

      glibcLocales

      python3
      python3.pkgs.pynvim
      python3.pkgs.pip

      pinnedPkgs.elixir_1_10

      pinentry
    ]
    ++ pkgs.lib.optionals localConfig.graphical graphicalPackages;

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
      delay = 6;
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

      extraConfig = ''
        pinentry-program ${pinentry}/bin/pinentry
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
