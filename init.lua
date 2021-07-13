-- This is a minimal init.lua to start up aniseed
-- This is based heavily off of magic kit by Olical
-- https://github.com/Olical/magic-kit/blob/main/init.lua

-- load early loading stuff first
-- this is mostly needed for Vimwiki, that set variables well before this init fully loads
vim.cmd("source ~/before.vim")

local execute = vim.api.nvim_command
local fn = vim.fn
local fmt = string.format

-- make the package path ~/.local/share/nvim/plug
local packer_path = fn.stdpath("data") .. "/site/pack"

function ensure (user, repo)
	local install_path = fmt("%s/packer/start/%s", packer_path, repo, repo)
	if fn.empty(fn.glob(install_path)) > 0 then
		execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
		execute(fmt("packadd %s", repo))
	end
end

ensure("wbthomason", "packer.nvim")

ensure("Olical", "aniseed")

-- load aniseed environment
vim.g["aniseed#env"] = {module = "init"}
