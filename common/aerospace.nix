# Window Manager for MacOS
{
  # https://github.com/LnL7/nix-darwin/blob/nix-darwin-24.11/modules/services/aerospace/default.nix
  # From 25.05, it's available in home-manager.
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.aerospace.enable
  # https://nikitabobko.github.io/AeroSpace/guide#default-config
  services.aerospace = {
    enable = false;
    settings = {
      # TODO: AeroSpace started at login is managed by home-manager and launchd instead of itself via this option.
      # start-at-login = true;
      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";
        # See: https://nikitabobko.github.io/AeroSpace/commands#resize;
        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";
        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace;
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";

        # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace;
        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";

        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth;
        alt-tab = "workspace-back-and-forth";
        # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor;
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        # See: https://nikitabobko.github.io/AeroSpace/commands#mode;
        alt-shift-semicolon = "mode service";
      };
      mode.service.binding = {
        esc = ["reload-config" "mode main"];
        r = ["flatten-workspace-tree" "mode main"]; # reset layout
        f = ["layout floating tiling" "mode main"]; # Toggle between floating and tiling layout
        backspace = ["close-all-windows-but-current" "mode main"];

        alt-shift-h = ["join-with left" "mode main"];
        alt-shift-j = ["join-with down" "mode main"];
        alt-shift-k = ["join-with up" "mode main"];
        alt-shift-l = ["join-with right" "mode main"];
      };
    };
  };
}
