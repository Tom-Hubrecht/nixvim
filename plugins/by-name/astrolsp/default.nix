{ lib, helpers, ... }:

let
  inherit (helpers.defaultNullOpts)
    mkAttrsOf
    mkBool
    mkListOf
    mkPositiveInt
    ;
in

helpers.neovim-plugin.mkNeovimPlugin {
  name = "astrolsp";
  originalName = "astrolsp";
  package = "astrolsp";

  maintainers = [ lib.maintainers.thubrecht ];

  settingsOptions = {
    features = {
      codelens = mkBool true "enable/disable codelens refresh on start.";
      inlay_hints = mkBool false "enable/disable inlay hints on start.";
      semantic_tokens = mkBool true "enable/disable semantic token highlighting.";
    };

    flags = mkAttrsOf lib.types.anything { } "Custom flags to be passed to all language servers.";

    formatting = {
      format_on_save = {
        enabled = mkBool true "Enable or disable format on save globally.";
        allow_filetypes = mkListOf lib.types.str [ ] "Enable format on save for specified filetypes only.";
        ignore_filetypes = mkListOf lib.types.str [ ] "Disable format on save for specified filetypes.";
      };

      disabled =
        mkListOf lib.types.str [ ]
          "Disable formatting capabilities for specific language servers.";

      timeout_ms = mkPositiveInt 1000 "Formatting timeout.";
    };

    # TODO: Add the remaining options
  };
}
