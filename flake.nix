{
  description = "Devu's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, chaotic, ... }@inputs:
    let
      vars = import ./vars.nix;
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in {
      devShells."x86_64-linux".cpp = let
        devTools = with pkgs; [ clang cmake ninja pkg-config ];
        devLibs = with pkgs; [
          vulkan-headers vulkan-loader libGL sdl3 wayland
          libx11 libxrandr libxinerama libxcursor libxi
          stdenv.cc.cc.lib
          boost
        ];

        pkgNames = builtins.concatStringsSep ", " (map (p: p.pname or p.name) devLibs);
      in pkgs.mkShell {
        packages = devTools ++ devLibs;

        shellHook = ''
          export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath devLibs}:$LD_LIBRARY_PATH"

          cat << 'EOF'
          -----------------------------------
          ▄▖      ▄▖▌   ▜ ▜   ▜      ▌   ▌
          ▌ ▟▖▟▖  ▚ ▛▌█▌▐ ▐   ▐ ▛▌▀▌▛▌█▌▛▌
          ▙▖▝ ▝   ▄▌▌▌▙▖▐▖▐▖  ▐▖▙▌█▌▙▌▙▖▙▌

          Libs available: ${pkgNames}
          -----------------------------------
          EOF
        '';
      };

      nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs vars self; };
        modules = [
          chaotic.nixosModules.default
          ./hosts/pc/default.nix
        ];
      };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs vars self; };
        modules = [
          ./hosts/laptop/default.nix
        ];
      };
    };
}
