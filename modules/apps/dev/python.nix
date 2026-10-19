{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (python314.withPackages (pythonPackages: [ pythonPackages.pip ]))
  ];
}
