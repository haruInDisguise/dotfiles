-- Fist time setup of my Neovim Configuration! Bootstrapping... yay

-- As of now, we depend on an external script to setup the fundamentals of this vim configuration
-- DONT DO THIS. I will keep this as a warning to every fool wandering this lonely planet in an attempt to live a fulfilling life.
--		local os_exec_code = os.execute([[sh << EOF
--		mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/packer/start && \
--		git clone 'https://github.com/wbthomason/packer.nvim' "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/packer/start/packer.nvim
--		EOF
--		]])

-- TODO trim or format comments. lua fmt?

local config = {}

local annoy_me_on_bootstrap = function()

end

-- options: Override some defaults in this setup
local init = function(utils, options)
    local options = options or {}
    local utils = utils

    -- A pure lua approach. Does not depend on system specific functionality.
    -- Snippet snatched and modified from https://github.com/wbthomason/packer.nvim#Bootstrapping
    local execute = vim.api.nvim_command
    local fn = vim.fn

    -- Resolves to: $XDG_DATA_HOME/nvim
    local install_path = options.install_path or fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    local package_manager_repo = options.packge_manager_repo or 'https://github.com/wbthomason/packer.nvim'

    local be_verbose = options.be_verbose or nil

    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({'git', 'clone', package_manager_repo, install_path})
      execute 'packadd packer.nvim'
    end
end

init()
