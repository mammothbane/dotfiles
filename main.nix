{ localConfigFile ? ./local.nix }:
let
  nixpkgsConfig = import ./nixpkgs-config.nix;

  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    config = nixpkgsConfig // {};
  };

  aliases = ''
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'

    alias xclip='xclip -selection c'
    alias rs="exec -l $SHELL"

    alias hm=home-manager

    ops() {
      eval $(op signin "$1")
    }
  '';

  ownpkgs-root  = pkgs.callPackage sources.ownpkgs {};
  ownpkgs       = ownpkgs-root.pkgs;
  ownlib        = ownpkgs-root.lib;

  localConfig = with ownlib; let
    tryLocal  = tryCallPackage localConfigFile {};
    local     = orDefault tryLocal {};
  in {
    graphical = false;
  } // local;

  pinentry = if localConfig.graphical
    then pkgs.pinentry-gnome
    else pkgs.pinentry;

  graphicalPackages = with pkgs; with ownpkgs; [
    discord
    minecraft

    alacritty

    yubikey-personalization
    yubioath-desktop

    slack
  ];

  graphicalPrograms = {
    # obs-studio = {};
  };

in
{
  nixpkgs.config = nixpkgsConfig;
  xdg.configFile = {
    "nixpkgs/config.nix".source = ./nixpkgs-config.nix;

    "alacritty/alacritty.yml".text = builtins.toJSON {
      env.TERM = "xterm-256color";
      window.dimensions = {
      };

      key_bindings = [
      ];

      draw_bold_text_with_bright_colors = true;

      colors = builtins.fromJSON (builtins.readFile ./alacritty/base16-tomorrow-night.json);
    };
  } // (
    let
      overrides = builtins.attrNames (builtins.readDir ./override/xdg-config);
    in pkgs.lib.foldl (acc: x: acc // { "${x}" = { recursive = true; source = ./override/xdg-config + "/${x}"; }; }) {} overrides
  );

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
      yaml2json

      _1password

      nix-index
      haskellPackages.niv

      cordless

      glibcLocales

      python3
      python3.pkgs.pip

      rustup

      elixir_1_10

      gocode

      pinentry
    ]
    ++ pkgs.lib.optionals localConfig.graphical graphicalPackages;

    sessionVariables = {
      GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
      EDITOR = "nvim";
      VISUAL = "nvim";
      KEYTIMEOUT = 1;
      NIX_PATH = "$HOME/.nix-defexpr/channels";
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

      PATH = "$PATH:$HOME/bin";
    };
  };

  news.display = "silent";

  programs = {
    home-manager.enable = true;
    neovim = import ./vim.nix { inherit pkgs sources; };
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

      matchBlocks = let
        viaProxy = { host, user, name ? null }: let
          config = {
            inherit user;
            hostname = host;
            proxyJump = "vpn.tulip.co";
          };
        in

        { "${host}" = config; }
          // (if name != null then { "${name}" = config; } else {});

        nonProxied = {
          "somali-derp.com" = {
            user = "mammothbane";
          };

          "vpn.tulip.co" = {
            user = "developer";
          };
        };

        proxied = [
          { user = "ubuntu"; host = "deploy.bulb.cloud"; name = "tulip-staging"; }
          { user = "ubuntu"; host = "deploy.tulip.co"; name = "tulip-prod"; }
          { user = "ubuntu"; host = "deploy-eu-central-1.dmgmori-tulipintra.net"; name = "tulip-dmgm"; }
        ];
      in
      pkgs.lib.foldl (acc: x: acc // (viaProxy x))
        nonProxied
        proxied;

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
      GSM_SKIP_SSH_AGENT_WORKAROUND = "1";
    };

    startServices = true;
  };
}
