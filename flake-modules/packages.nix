{
  perSystem =
    {
      pkgsUnfree,
      config,
      inputs',
      ...
    }:
    {
      packages = import ../docs {
        # Building the docs evaluates each plugin's default package, some of which are unfree
        pkgs = pkgsUnfree;
        inherit (inputs') nuschtosSearch;
      };

      # Test that all packages build fine when running `nix flake check`.
      checks = config.packages;
    };
}
