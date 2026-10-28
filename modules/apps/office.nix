{ pkgsUnstable, ... }:
{
  environment.systemPackages = with pkgsUnstable; [
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_US
    hunspellDicts.pl_PL
  ];
}
