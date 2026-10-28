{ pkgs, pkgsUnstable, ... }:

{
  fonts.packages = with pkgs; [ rubik nerd-fonts.ubuntu nerd-fonts.jetbrains-mono ];
  environment.systemPackages = with pkgsUnstable; [ nwg-look ocs-url ];
}
