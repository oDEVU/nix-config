{ inputs, pkgs, vars, ... }:

{
  home-manager.sharedModules = [ inputs.spicetify-nix.homeManagerModules.default ];

  home-manager.users.${vars.userName}.programs.spicetify =
    let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [ hidePodcasts fullAppDisplay coverAmbience spicyLyrics shuffle ];
      theme = spicePkgs.themes.text;
    };
}
