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

  environment.sessionVariables = {
    BIG_RAG_DOCS_DIR = "/home/devu/.lmstudio/docs";
    BIG_RAG_DB_DIR = "/home/devu/.lmstudio/big-rag-db";
  };

}
