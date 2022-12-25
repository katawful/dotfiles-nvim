local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local package_path = vim.fn.stdpath("data") .. "/lazy"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
end
vim.opt.runtimepath:prepend(lazy_path)
function ensure (repo, package, dir)
  if not dir then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      repo,
      package_path,
    })
    vim.api.nvim_command(string.format("packadd %s", package))
  else
    local install_path = string.format("%s/%s", package_path, package)
    vim.fn.system(string.format("rm -r %s", install_path))
    vim.fn.system(string.format("ln -s %s %s", repo, package_path))
    vim.api.nvim_command(string.format("packadd %s", package))
  end
end
ensure("~/Git\\ Repos/katcros-fnl", "katcros-fnl", true)
ensure("Olical/aniseed", "aniseed")
vim.g["aniseed#env"] = {module = "init", compile = true}