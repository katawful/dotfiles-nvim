local packer_path = vim.fn.stdpath("data") .. "/site/pack"
function ensure (user, repo)
  local install_path = string.format("%s/packer/start/%s", packer_path, repo, repo)
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command(string.format("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    vim.api.nvim_command(string.format("packadd %s", repo))
  end
end
function local_ensure (dir, repo)
    local install_path = string.format("%s/packer/start/%s", packer_path, repo)
    local pack_path = string.format("%s/packer/start/", packer_path)
    vim.fn.system(string.format("rm -r %s", install_path))
    vim.fn.system(string.format("ln -s %s %s", dir, pack_path))
    vim.api.nvim_command(string.format("packadd %s", repo))
end
ensure("lewis6991", "impatient.nvim")
require("impatient")
ensure("wbthomason", "packer.nvim")
local_ensure("~/Git\\ Repos/katcros-fnl/", "katcros-fnl")
ensure("Olical", "aniseed")
vim.g["aniseed#env"] = {module = "init", compile = true}