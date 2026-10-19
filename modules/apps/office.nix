{ pkgs, vars, ... }:
{
  environment.systemPackages = with pkgs; [
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_US
    hunspellDicts.pl_PL
  ];
}
