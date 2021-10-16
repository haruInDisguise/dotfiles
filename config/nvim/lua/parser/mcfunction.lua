local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.mcfunction = {
  install_info = {
    url = "/mnt/data/games/minecraft/custom/extern/tree-sitter-mcfunction",
    files = {"src/parser.c"},
  },
  filetype = "mcfunction"
}
