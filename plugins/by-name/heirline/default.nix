{ lib, ... }:

lib.nixvim.neovim-plugin.mkNeovimPlugin {
  name = "heirline";
  originalName = "heirline.nvim";
  package = "heirline-nvim";

  maintainers = [ lib.maintainers.thubrecht ];
}
