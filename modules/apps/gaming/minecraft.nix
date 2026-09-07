{ pkgs, inputs, vars, ... }:

{
  home-manager.users.${vars.userName} = {
    imports = [
        inputs.xmcl.homeModules.xmcl
      ];

      programs.xmcl = {
        enable = true;
        commandLineArgs = [
          "--password-store=\"gnome-libsecret\""
        ];
        jres = [
          pkgs.jre8
          pkgs.temurin-jre-bin-17
        ];
      };
  };
}
