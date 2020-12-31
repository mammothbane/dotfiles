let
  aliases = import ./aliases.nix;

in {
  programs = {
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

    bash = {
      enable = true;

      initExtra = aliases;
    };

    command-not-found.enable = true;
    readline = {
      enable = true;
      variables = {
        editing-mode = "vi";
        show-mode-in-prompt = true;
      };
    };

    direnv = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
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
  };
}
