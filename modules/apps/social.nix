{ pkgsUnstable, ... }:
{
  environment.systemPackages = with pkgsUnstable; [ discord ];
}