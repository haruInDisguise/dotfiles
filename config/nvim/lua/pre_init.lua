-- Fist time setup of my Neovim Configuration! Bootstrapping... yay
local options = options or {}
local utils = utils

-- A pure lua approach. Does not depend on system specific functionality.
-- Snippet snatched and modified from https://github.com/wbthomason/packer.nvim#Bootstrapping
local fn = vim.fn

-- Defaults to $XDG_DATA_HOME/nvim
local install_path = options.install_path or fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local package_manager_repo = options.packge_manager_repo or 'https://github.com/wbthomason/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', package_manager_repo, install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

