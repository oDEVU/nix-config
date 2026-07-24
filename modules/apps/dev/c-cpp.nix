{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ ninja cmake clang ];
}