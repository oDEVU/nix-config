{ pkgs, ... }:

{
  fonts.packages = with pkgs; [ rubik nerd-fonts.ubuntu nerd-fonts.jetbrains-mono ];
  environment.systemPackages = with pkgs; [ nwg-look ocs-url ];
}
