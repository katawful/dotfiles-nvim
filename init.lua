local execute = vim.api.nvim_command
local fn = vim.fn
local fmt = string.format
local packer_path = fn.stdpath("data") .. "/site/pack"
function ensure (user, repo)
  local install_path = fmt("%s/packer/start/%s", packer_path, repo, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end
function local_ensure (dir, repo)
    local install_path = fmt("%s/packer/start/%s", packer_path, repo)
    local pack_path = fmt("%s/packer/start/", packer_path)
    fn.system(fmt("rm -r %s", install_path))
    fn.system(fmt("ln -s %s %s", dir, pack_path))
    execute(fmt("packadd %s", repo))
end
ensure("lewis6991", "impatient.nvim")
require("impatient")
ensure("wbthomason", "packer.nvim")
local_ensure("~/Git\\ Repos/katcros-fnl/", "katcros-fnl")
ensure("Olical", "aniseed")
vim.g["aniseed#env"] = {module = "init", compile = true}