{ pkgs, self, ... }:
{
  environment.shellAliases = {
    devshell-cpp = "nix develop ${self}#cpp --no-write-lock-file";
  };
}
