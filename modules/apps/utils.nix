{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome-disk-utility distrobox kdePackages.ark kdePackages.gwenview kdePackages.dolphin kdePackages.kio-extras wl-clipboard lact cosmic-settings cosmic-settings-daemon nwg-look qbittorrent p7zip unzip unrar
  ];
}
