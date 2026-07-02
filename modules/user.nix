{ pkgs, vars, ... }:

{
  users.users.${vars.userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "render" ];
    shell = pkgs.fish;
    hashedPassword = "$6$H68eUQunz7/oBRVQ$AMjgP.fF/UFQpRPVPQo6gMQW2ogkbsTd6ECLDWiPjUhy.p6/pm2m4vBQGkuxD2i7gXQmWsVGxxev8JLOYQw6e0";
  };

  programs.fish.enable = true;
}
