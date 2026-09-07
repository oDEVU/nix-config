{ pkgs, inputs, ... }:

{
  #programs.envision = {
  #  enable = true;
  #  openFirewall = true;
  #};

  services.wivrn = {
    enable = true;
    openFirewall = true;
  };

  # For steam games:
  # PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1 %command%
}
