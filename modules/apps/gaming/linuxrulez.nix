{ pkgs, ... }:

{
  programs.nix-ld.enable = true;
  services.envfs.enable = true;

  environment.systemPackages = with pkgs; [
    python3
    zenity
    yad
    xrandr
    gawk
  ];
}
