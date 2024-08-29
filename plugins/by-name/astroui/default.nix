{
  lib,
  helpers,
  config,
  pkgs,
  options,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOrder
    ;

  opts = options.plugins.astroui;
in

{
  meta = {
    maintainers = [ helpers.maintainers.thubrecht ];
    nixvimInfo = {
      description = null;
      url = opts.package.default.meta.homepage;
      path = [
        "plugins"
        "astroui"
      ];
    };
  };

  options.plugins.astroui = {
    enable = mkEnableOption "astroui";

    package = lib.mkPackageOption pkgs "astroui" {
      default = [
        "vimPlugins"
        "astroui"
      ];
    };

    settings = helpers.mkSettingsOption {
      description = "Options provided to the `require('astroui').setup` function.";
      options = { };
      example = { };
    };
  };

  config =
    let
      cfg = config.plugins.astroui;
    in
    mkIf cfg.enable {
      extraPlugins = [ cfg.package ];

      # AstroUI needs to be loaded as soon as possible
      extraConfigLua = mkOrder 250 ''
        require('astroui').setup(${helpers.toLuaObject cfg.settings})
      '';
    };
}
