{ pkgs, inputs, vars, ... }:

{
  my.hyprland.autostart = [ "simple-wallpaper-engine --background" ];

  home-manager.users.${vars.userName} = {
    imports = [
      inputs.simple-wallpaper-engine.homeManagerModules.default
    ];

    programs.simple-wallpaper-engine.enable = true;

    home.packages = [ pkgs.linux-wallpaperengine ];
  };
}
