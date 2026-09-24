{ inputs, vars, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.userName}.home.stateVersion = vars.systemVersion;
  };
}
