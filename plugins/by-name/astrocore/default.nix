{
  lib,
  helpers,
  config,
  pkgs,
  options,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf mkOrder;

  inherit (helpers.defaultNullOpts) mkBool mkEnum mkPositiveInt;

  opts = options.plugins.astrocore;
in

{
  meta = {
    maintainers = [ helpers.maintainers.thubrecht ];
    nixvimInfo = {
      description = null;
      url = opts.package.default.meta.homepage;
      path = [
        "plugins"
        "astrocore"
      ];
    };
  };

  options.plugins.astrocore = {
    enable = mkEnableOption "astrocore";

    package = lib.mkPackageOption pkgs "astrocore" {
      default = [
        "vimPlugins"
        "astrocore"
      ];
    };

    settings = helpers.mkSettingsOption {
      description = "Options provided to the `require('astrocore').setup` function.";
      options = {
        features = {
          autopairs = mkBool true "Whether to enable autopairs on start.";
          cmp = mkBool true "Whether to enable cmp on start.";
          diagnostic_mode =
            mkEnum
              [
                0
                1
                2
                3
              ]
              3
              ''
                Diagnostic mode on start:

                - 0 = off
                - 1 = no signs/virtual text
                - 2 = no virtual text
                - 3 = on
              '';
          highlighturl = mkBool true "Whether to enable url highlighting on start.";
          large_buf = {
            size = mkPositiveInt (1024 * 100) "Maximum filesize for enabling all features.";
            lines = mkPositiveInt 1000 "Maximum filesize for enabling all features.";
          };
          notifications = mkBool true "Whether to enable notifications on start.";
        };
      };
      # TODO: Finish examples
      example = { };
    };
  };

  config =
    let
      cfg = config.plugins.astrocore;
    in
    mkIf cfg.enable {
      extraPlugins = [ cfg.package ];

      # AstroCore needs to be loaded as soon as possible
      extraConfigLua = mkOrder 250 ''
        require('astrocore').setup(${helpers.toLuaObject cfg.settings})
      '';
    };
}
