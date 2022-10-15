# Bootstrapping

Since I use Aniseed to compile and run Fennel files, I need to use a minimal init.lua that handles
this.

```
local packer_path = vim.fn.stdpath("data") .. "/site/pack"
```

Get the packer.nvim path. This will be used to simplify paths within the bootstrap.

```lua
function ensure (user, repo)
  local install_path = string.format("%s/packer/start/%s", packer_path, repo, repo)
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command(string.format("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    vim.api.nvim_command(string.format("packadd %s", repo))
  end
end
```

This function "ensures" that external repos are installed by force. It updates the plugin repo to
the appropriate package path, then manually adds the package.

```lua
function local_ensure (dir, repo)
    local install_path = string.format("%s/packer/start/%s", packer_path, repo)
    local pack_path = string.format("%s/packer/start/", packer_path)
    vim.fn.system(string.format("rm -r %s", install_path))
    vim.fn.system(string.format("ln -s %s %s", dir, pack_path))
    vim.api.nvim_command(string.format("packadd %s", repo))
end
```

This function "ensures" that local repos are installed by force. This was needed to load my own
personal fennel macros that are managed by git. This has to manually link the repo to the package
path, something that packer already does for local repos.

```lua
ensure("lewis6991", "impatient.nvim")
require("impatient")
```

[impatient.nvim](https://github.com/lewis6991/impatient.nvim) is a bytecode caching plugin to
speed up the loading of Lua files. This has to be required now in order to speed up plugins loaded
after.

```lua
ensure("wbthomason", "packer.nvim")
```

[packer.nvim](https://github.com/wbthomason/packer.nvim) is a package management plugin. It loads
and manages plugins. There is no needed configuration for the bootstrap.

```lua
local_ensure("~/Git\\ Repos/katcros-fnl/", "katcros-fnl")
```

[katcros-fnl](https://github.com/katawful/katcros-fnl) are my Fennel macros, primarily designed
for Neovim. Since I constantly develop these, they are loaded locally.

```lua
ensure("Olical", "aniseed")
vim.g["aniseed#env"] = {module = "init", compile = true}
```

[Aniseed](https://github.com/Olical/aniseed) is a runtime environment for Fennel and Neovim. It
provides Clojure-like additions, like modules. It is used here to initialize my configurations.



# init.fnl

```fennel
(module init {require-macros [katcros-fnl.macros.nvim.packer.macros
                              katcros-fnl.macros.nvim.api.utils.macros
                              katcros-fnl.macros.nvim.api.autocommands.macros
                              katcros-fnl.macros.nvim.api.options.macros]
              autoload {c aniseed.compile
                        s aniseed.string
                        render katdotnvim.utils.export.render}
              require {: au
                       : config
                       : maps
                       sys system}})
```

This is the header for this module. We use `autoload` for stuff we want to use within the module.
The modules in `require` need to be loaded anyways to load in said configs.


### System Config Files

[Autocommands](../fnl/au.fnl)   
[System-wide Configs](../fnl/config.fnl)   
[Maps](../fnl/maps.fnl)   
[System-wide variables](../fnl/system.fnl)   

```fennel
(defn checkForCompile [] (let [file (io.open :/home/kat/.config/nvim/lua/packer_compiled.lua
                                             :r)]
                           (if (not= file nil)
                               (do
                                 (io.close file)
                                 (require :packer_compiled))
                               (do
                                 false))))
(checkForCompile)
```

This is used to make sure packer.nvim is actually compiled on startup. I don't know if this
actually works or not.


## Plugins


```fennel
(def plugins [])
```

Here we are defining a sequential table of plugins that can be loaded by packer.nvim later. This
is done for easier management of all the plugins.


### Bootstrapped Plugins

```fennel
(table.insert plugins "~/Git Repos/katcros-fnl/")
(table.insert plugins :wbthomason/packer.nvim)
(table.insert plugins :Olical/aniseed)
(table.insert plugins :lewis6991/impatient.nvim)
```

These are the plugins we loaded in with the [bootstrap](#bootstrapping), they're updated with
packer.nvim.



### Treesitter

```fennel
(table.insert plugins {1 :nvim-treesitter/nvim-treesitter
                       :run ":TSUpdate"
                       :config (fn [] (require :plugins.treesitter.config))})
```

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) is an abstraction layer for
tree-sitter that hooks tree-sitter parsers into Neovim.

```fennel
(table.insert plugins {1 :nvim-treesitter/playground
                       :config (fn [] (require :plugins.treesitter.playground.config))})
```

[treesitter-playground](https://github.com/nvim-treesitter/playground) is a test plugin for
tree-sitter.

```fennel
(table.insert plugins {1 :p00f/nvim-ts-rainbow
                       :config (fn [] (require :plugins.treesitter.rainbow.config))})
```

[ts-rainbow](https://github.com/p00f/nvim-ts-rainbow) colors parentheses for tree-sitter equipped
languages.

```fennel
(table.insert plugins {1 :romgrk/nvim-treesitter-context
                       :config (fn [] (require :plugins.treesitter.context.config))})
```

[treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) shows code
context within blocks

```fennel
(table.insert plugins {1 :nvim-treesitter/nvim-tree-docs
                       :config (fn [] (require :plugins.treesitter.docs.config))})
```

[nvim-tree-docs](https://github.com/nvim-treesitter/nvim-tree-docs) creates docs for supported
languages. Currently don't use.

```fennel
(table.insert plugins {1 :SmiteshP/nvim-gps
                       :config (fn [] (require :plugins.nvim-gps.config))})
```

[nvim-gps](https://github.com/SmiteshP/nvim-gps) shows position in statusline. Currently don't
use.


### Fluff

```fennel
(table.insert plugins {1 :rcarriga/nvim-notify
                       :config (fn [] (set vim.notify (require :notify))
                                 (vim.notify.setup {:stages :slide}))})
```

[nvim-notify](https://github.com/rcarriga/nvim-notify) is a notification manager. It takes over
`vim.notify`.

```fennel
(table.insert plugins :katawful/kat.vim)
(table.insert plugins {1 "~/Git Repos/katdotnvim/"
                       :config (fn [] ((. (require :plugins.colors.time) :set-colors))
                                 ((. (require :plugins.colors.scheme) :set*)))})
```

These are my colorschemes.

```fennel
(table.insert plugins {1 :nvim-lualine/lualine.nvim
                       :config (fn [] (require :plugins.lualine.config))})
```

[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) is a statusline plugin.

```fennel
(table.insert plugins {1 :junegunn/goyo.vim
                       :config (fn [] (require :plugins.goyo.config))})
```

[goyo.vim](https://github.com/junegunn/goyo.vim) is a distraction free writing view.

```fennel
(table.insert plugins :kyazdani42/nvim-web-devicons)
```

[nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) is devicon support for Neovim.

```fennel
(table.insert plugins {1 :lukas-reineke/indent-blankline.nvim
                       :config (fn [] (require :plugins.indent-blankline.config))})
```

[indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim) shows indentation as
virtual text.

```fennel
(table.insert plugins {1 "~/Git Repos/vim-startify/"
                       :config (fn [] (require :plugins.startify.config))})
```

[vim-startify](https://github.com/mhinz/vim-startify) is a start-page plugin.

```fennel
(table.insert plugins {1 :gelguy/wilder.nvim
                       :config (fn [] (require :plugins.wilder.config))})
```

[wilder.nvim](https://github.com/gelguy/wilder.nvim) is a completion plugin for command-line and
search.

```fennel
(table.insert plugins "~/Git Repos/syntax-test")
```

This is a tiny syntax plugin for me to look at various hl groups. It's only installed with
packer.nvim to make management easier.

```fennel
(table.insert plugins "~/Git Repos/kreative")
```

[Kreative](https://github.com/katawful/kreative) is a 16 color GUI colorscheme generator plugin
that I made.

```fennel
(table.insert plugins {1 :nanozuki/tabby.nvim
                       :config (fn [] (require :plugins.tabby.config))})
```

[tabby.nvim](https://github.com/nanozuki/tabby.nvim) is a tabline plugin.

```fennel
(table.insert plugins {1 :David-Kunz/markid
                       :config (fn [] (require :plugins.markid.config))})
```

[markid](https://github.com/David-Kunz/markid) colors symbols based on scope. Currently do not
use.


### Git

```fennel
(table.insert plugins {1 :lewis6991/gitsigns.nvim
                       :config (fn [] (require :plugins.gitsigns.config))})
```

[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim/) shows git status in files in various
ways.

```fennel
(table.insert plugins {1 :tpope/vim-fugitive
                       :config (fn [] (require :plugins.fugitive.config))})
```

[vim-fugitive](https://github.com/tpope/vim-fugitive) is a Git management plugin.


### Editing

```fennel
(table.insert plugins {1 :Olical/conjure
                       :branch :develop
                       :config (fn [] (require :plugins.conjure.config))})
```

[Conjure](https://github.com/Olical/conjure) is an interactive evaluation plugin. It hooks into
various REPLs for ease of use.

```fennel
(table.insert plugins {1 :eraserhd/parinfer-rust
                       :run "cargo build --release"})
```

[parinfer-rust](https://github.com/eraserhd/parinfer-rust) is a rust based parinfer plugin for
LISPs. Requires `cargo` to be installed.

```fennel
(table.insert plugins {1 :lervag/vimtex
                       :config (fn [] (require :plugins.latex.config))})
```

[VimTeX](https://github.com/lervag/vimtex) is a LaTeX filetype plugin.

```fennel
(table.insert plugins "~/Git Repos/obse.vim")
```

[obse.vim](https://github.com/katawful/obse.vim) is a syntax plugin for Oblivion.

```fennel
(table.insert plugins "~/Git Repos/obluavim")
```

[obluavim](https://github.com/katawful/obluavim) is my in-progress filetype plugin for Oblivion.

```fennel
(table.insert plugins {1 :katawful/Obli-Vim-Docs
                       :ft :obse})
```

[Obli-Vim-Docs](https://github.com/katawful/Obli-Vim-Docs) are OBSE docs built as Vim help files.

```fennel
(table.insert plugins :vim-scripts/bnf.vim)
```

[bnf.vim](https://github.com/vim-scripts/bnf.vim) is a syntax plugin for BNF files.

```fennel
(table.insert plugins :killphi/vim-ebnf)
```

[vim-ebnf](https://github.com/killphi/vim-ebnf) is a syntax plugin for EBNF files.

```fennel
(table.insert plugins {1 :SirVer/ultisnips
                       :config (fn [] (require :plugins.ultisnips.config))})
```

[UltiSnips](https://github.com/SirVer/ultisnips) is a snippet plugin. Require python and pynvim
(python-neovim on Arch).

```fennel
(table.insert plugins :tpope/vim-commentary)
```

[vim-commentary](https://github.com/tpope/vim-commentary) is a comment editing plugin.


### LSP

```fennel
(table.insert plugins {1 :neovim/nvim-lspconfig})
```

[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) configures LSPs.

```fennel
(table.insert plugins :williamboman/mason-lspconfig.nvim)
```

[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) uses mason.nvim to
hook into nvim-lspconfig.

```fennel
(table.insert plugins {1 :williamboman/mason.nvim
                       :config (fn [] (require :plugins.lsp.config))})
```

[mason.nvim](https://github.com/williamboman/mason.nvim) installs LSPs.


### File Management

```fennel
(table.insert plugins {1 :junegunn/fzf
                       :run "./install --all"})
```

[FZF](https://github.com/junegunn/fzf) is a command-line fuzzy finder.

```fennel
(table.insert plugins {1 "~/Git Repos/dirbuf.nvim"
                       :config (fn [] (require :plugins.dirbuf.config))})
```

[dirbuf.nvim](https://github.com/elihunter173/dirbuf.nvim) is a dired-like file manager.

```fennel
(table.insert plugins {1 :ibhagwan/fzf-lua
                       :requires :vijaymarupudi/nvim-fzf
                       :config (fn [] (require :plugins/fzf/config))})
```

[fzf-lua](https://github.com/ibhagwan/fzf-lua) is a binding for FZF.

```fennel
(table.insert plugins :airblade/vim-rooter)
```

[vim-rooter](https://github.com/airblade/vim-rooter) is a root directory finder/manager.

```fennel
(table.insert plugins {1 :kyazdani42/nvim-tree.lua
                       :config (fn [] (require :plugins.nvim-tree.config))})
```

[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) is a file manager. Currently do not
use.


### Other

```fennel
(table.insert plugins :andweeb/presence.nvim)
```

[presence.nvim](https://github.com/andweeb/presence.nvim) shows Neovim status for Discord.

```fennel
(table.insert plugins {1 :nvim-neorg/neorg
                       :config (fn [] (require :plugins.neorg.config))
                       :requires :nvim-lua/plenary.nvim})
```

```fennel
(table.insert plugins {1 "~/Git Repos/neorg/"
                       :config (fn [] (require :plugins.neorg.config))
                       :requires :nvim-lua/plenary.nvim})
```

[Neorg](https://github.com/nvim-neorg/neorg) is a markup language and organization plugin.


## packer.nvim Call

```fennel
((. (require :packer) :startup) {1 (fn [use] (each [_ v (ipairs plugins)] (use v)))
                                 :config {:display {:open_fn (. (require :packer.util)
                                                                :float)}
                                          :compile_path (.. (vim.fn.stdpath :config)
                                                            :/lua/packer_compiled.lua)}})
```

Here we call `packer.nvim`. We iterate over the table `plugins` to load each plugin, and also set
the configs desired for `packer.nvim` itself.


## External File Compilation

```fennel
;;; after/ftplugin
(c.glob :*.fnl :/home/kat/.config/nvim/after/ftplugin
        :/home/kat/.config/nvim/after/ftplugin)
;;; plugin
(c.glob :*.fnl :/home/kat/.config/nvim/plugin :/home/kat/.config/nvim/plugin)
;;; autoload
(c.glob :*.fnl :/home/kat/.config/nvim/autoload
        :/home/kat/.config/nvim/autoload)
;;; ftplugin
(c.glob :*.fnl :/home/kat/.config/nvim/ftplugin
        :/home/kat/.config/nvim/ftplugin)
```

We need to compile files not found in `~/.config/nvim/fnl/`, we can use Aniseed for that.


## Packer Compile Check

```fennel
; see if we need to compile packer
(if (= (checkForCompile) false)
    ((. (require :packer) :compile)))
```

Just double checking that `packer.nvim` compiles properly.


## Internal Plugin Loading

```fennel
(require :plugins.session.init)
```

Some internal config plugins cannot be loaded implicitly, so they must be loaded last.
