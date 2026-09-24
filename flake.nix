{
  description = "Devu's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    simple-wallpaper-engine = {
      url = "github:Maxnights/simple-linux-wallpaperengine-gui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xmcl = {
      url = "github:x45iq/xmcl-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, chaotic, ... }@inputs:
    let
      system = "x86_64-linux";
      vars = import ./vars.nix;
      pkgs = nixpkgs.legacyPackages.${system};

      mkHost = hostDir: extra: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs vars self; };
        modules = [ hostDir ] ++ extra;
      };
    in {
      devShells.${system}.cpp = import ./modules/apps/dev/devshells/cpp.nix { inherit pkgs; };

      nixosConfigurations = {
        pc = mkHost ./hosts/pc [ chaotic.nixosModules.default ];
        laptop = mkHost ./hosts/laptop [ ];
      };
    };
}
