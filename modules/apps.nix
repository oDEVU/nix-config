{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "pnpm-10.29.2" ];

  networking.networkmanager.enable = true;
  services.flatpak.enable = true;
  virtualisation.podman.enable = true;
  services.geoclue2.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
           action.id == "org.freedesktop.udisks2.filesystem-mount") &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  services.gnome.gnome-software.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;
  services.upower.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Core
    kitty git wget htop curl zip p7zip pciutils usbutils killall fastfetch brave polkit_gnome

    # Dev
    ninja cmake clang android-tools gitkraken

    # Utils
    gnome-disk-utility distrobox kdePackages.ark kdePackages.gwenview kdePackages.dolphin kdePackages.kio-extras

    # GUI Apps
    wl-clipboard heroic lact discord blender obs-studio zed-editor cosmic-settings cosmic-settings-daemon nwg-look
  ];
}
