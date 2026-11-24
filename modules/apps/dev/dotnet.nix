{ pkgsUnstable, ... }:
{
  environment.systemPackages = with pkgsUnstable; [ dotnet ];
}
