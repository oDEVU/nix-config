{ pkgs, pkgsUnstable, ... }:
{
  environment.systemPackages = with pkgs; [
    pkgsUnstable.gnome-disk-utility distrobox
    pkgsUnstable.kdePackages.ark pkgsUnstable.kdePackages.gwenview
    pkgsUnstable.kdePackages.dolphin kdePackages.kio-extras
    wl-clipboard grim slurp tree lact cosmic-settings cosmic-settings-daemon
    pkgsUnstable.qbittorrent p7zip unzip unrar
  ];
}
