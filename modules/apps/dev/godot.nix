{ pkgsUnstable, ... }:
{
  environment.systemPackages = with pkgsUnstable; [ godot_4 ];
}
