{ pkgs, pkgsUnstable, ... }:
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
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pkgsUnstable.kitty git wget htop curl zip p7zip pciutils usbutils killall fastfetch polkit_gnome playerctl
    pkgsUnstable.brave
    (writeShellScriptBin "brave-dev" ''
      exec ${pkgsUnstable.brave}/bin/brave \
        --remote-debugging-address=127.0.0.1 \
        --remote-debugging-port=9222 "$@"
    '')
    (makeDesktopItem {
      name = "brave-dev";
      desktopName = "Brave Dev";
      genericName = "Web Browser";
      comment = "Brave with Capri browser integration enabled";
      exec = "brave-dev %U";
      icon = "brave";
      categories = [ "Network" "WebBrowser" ];
      terminal = false;
      startupWMClass = "Brave-browser";
    })
  ];
}
