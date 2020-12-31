{ pkgs, ... }:
{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        # font = "";

        # Allow a small subset of html markup
        markup = "yes";
        plain_text = "no";

        # The format of the message
        format = "<b>%s</b>\\n%b";

        # Alignment of message text
        alignment = "center";

        # Split notifications into multiple lines
        word_wrap = "yes";

        ignore_newline = "no";

        stack_duplicates = "yes";
        hide_duplicates_count = "yes";

        geometry = "420x50-15+49";

        shrink = "no";

        idle_threshold = 0;

        line_height = 3;

        separator_height = 2;

        padding = 6;
        horizontal_padding = 6;

        separator_color = "frame";

        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst -theme glue_pro_blue";

        # Browser for opening urls in context menu.
        browser = "${pkgs.chromium}/bin/chromium";

        # Align icons left/right/off
        icon_position = "left";
        max_icon_size = 80;

        # Define frame size and color
        frame_width = 3;
        frame_color = "#8EC07C";
      };

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
      };

      urgency_low = {
        frame_color = "#3B7C87";
        foreground = "#3B7C87";
        background = "#191311";
        timeout = 4;
      };
      urgency_normal = {
        frame_color = "#5B8234";
        foreground = "#5B8234";
        background = "#191311";
        timeout = 6;
      };

      urgency_critical = {
        frame_color = "#B7472A";
        foreground = "#B7472A";
        background = "#191311";
        timeout = 8;
      };
    };
  };
}
