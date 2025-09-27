{ pkgs, ... }:
{
  programs = {
    kitty.enable = true;
    #quickshell = {
    #  enable = true;
    #  activeConfig = "./quickshell/";
    #};
  };
  wayland.windowManager.hyprland = {
    enable =  true;
    #xwayland.enable = true;
    settings = {
      debug = {
        disable_logs = false;
        enable_stdout_logs = false;
      };
      monitor = ",preferred,auto,1,mirror,edP-1";
      input = {
        kb_layout = "br";
        kb_variant = "abnt2";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        #touchpad.natural_scroll = false;
        touchpad.disable_while_typing = 0;
      };
      gestures = {
        gesture = "3, horizontal, workspace";
      };
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      bind = [
        "$mainMod, return, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod, X, exit"
        "$mainMod, P, togglefloating"
        "$mainMod, J, togglesplit"
        "$mainMod, F, fullscreen"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };
}
