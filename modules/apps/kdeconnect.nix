{ vars, ... }:

{
  home-manager.users.${vars.userName}.services.kdeconnect = {
    enable = true;
    indicator = true; # tray icon, shows up in Noctalia's tray widget
  };

  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
