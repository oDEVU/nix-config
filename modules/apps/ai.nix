{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lmstudio
  ];

  hardware.graphics = {
    extraPackages = with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd
    ];
  };

  environment.variables = {
    HSA_OVERRIDE_GFX_VERSION = "11.0.0";
  };
}
