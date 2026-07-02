{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "pnpm-10.29.2" ];

  networking.networkmanager.enable = true;
  services.flatpak.enable = true;
  virtualisation.podman.enable = true;
  services.geoclue2.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-software.enable = true;

  environment.systemPackages = with pkgs; [
    # Core CLI
    kitty git wget htop curl zip p7zip pciutils usbutils killall fastfetch brave

    # Dev
    ninja cmake clang android-tools gitkraken

    # Utils
    gnome-disk-utility distrobox kdePackages.ark kdePackages.gwenview kdePackages.dolphin

    # GUI Apps
    wl-clipboard heroic lact discord blender obs-studio zed-editor cosmic-settings cosmic-settings-daemon nwg-look
  ];
}
