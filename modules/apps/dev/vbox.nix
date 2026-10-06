{ pkgs, vars, ... }:
{
   virtualisation.virtualbox.host.enable = true;
   virtualisation.virtualbox.host.enableExtensionPack = true;

   virtualisation.virtualbox.guest.enable = true;
   virtualisation.virtualbox.guest.dragAndDrop = true;

   users.extraGroups.vboxusers.members = [ "${vars.userName}" ];
}
