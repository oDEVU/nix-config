{ pkgs, ... }:
{
  security.pam.services.ly.enableGnomeKeyring = true;

  my.hyprland.autostart = [
    "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
  ];
}
