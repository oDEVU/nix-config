{ pkgsUnstable, ... }:
{
  environment.systemPackages = with pkgsUnstable; [ heroic ];
}
