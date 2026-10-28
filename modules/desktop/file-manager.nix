{ pkgs, pkgsUnstable, ... }:

{
  environment.systemPackages = with pkgsUnstable.kdePackages; [
    dolphin-plugins
    kio-admin
    kservice
    konsole
    kdegraphics-thumbnailers
    ffmpegthumbs
    breeze-icons
  ];

  environment.etc."xdg/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "kitty.desktop" ];
  };

  my.hyprland.autostart = [ "kbuildsycoca6 --noincremental" ];
}
