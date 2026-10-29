{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lmstudio
    rocminfo
    rocmPackages.rocm-smi
  ];

  hardware.graphics = {
    extraPackages = with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd
    ];
  };

  environment.sessionVariables = {
    HSA_OVERRIDE_GFX_VERSION = "11.0.0";
    LD_LIBRARY_PATH = "/run/opengl-driver/lib:${pkgs.rocmPackages.clr}/lib";
    BIG_RAG_DOCS_DIR = "/home/devu/.lmstudio/docs";
    BIG_RAG_DB_DIR = "/home/devu/.lmstudio/big-rag-db";
  };
}
