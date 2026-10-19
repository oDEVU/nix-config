{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ gitkraken zed-editor git gh];
}
