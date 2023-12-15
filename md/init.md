



# Bootstrapping


I use [lazy.nvim](https://github.com/folke/lazy.nvim) for my package manager. It is fairly new as
of this switch and comes with some nice features overall.

Since I use Aniseed to compile and run Fennel files, I need to use a minimal init.lua that handles
this.

```lua
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local package_path = vim.fn.stdpath("data") .. "/lazy"
```

This gets the lazy.nvim path to be used in the bootstrap.

```lua
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
```

This clones lazy.nvim to the system path. This is the suggested install method

```lua
function ensure (repo, package, dir)
  if not dir then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "https://github.com/" .. repo .. ".git",
      package_path .. "/" .. package,
    })
    vim.opt.runtimepath:prepend(package_path .. "/" .. package)
  else
    local install_path = string.format("%s/%s", package_path, package)
    vim.fn.system(string.format("rm -r %s", install_path))
    vim.fn.system(string.format("ln -s %s %s", repo, package_path))
    vim.opt.runtimepath:prepend(install_path)
  end
end
```

```lua
ensure("~/Git\\ Repos/NEOVIM/katcros-fnl", "katcros-fnl", true)
ensure("Olical/aniseed", "aniseed")
vim.opt.runtimepath:prepend(lazy_path)
```
This installs Aniseed and my macros. Since all of my plugins are loaded with Fennel files, I need
to be able to compile and access them before lazy.nvim actually runs. They will then be managed
with lazy.nvim after the bootstrap runs.

```lua
vim.g["aniseed#env"] = {module = "init", compile = true}
require('aniseed.env').init()
```

[Aniseed](https://github.com/Olical/aniseed) is a runtime environment for Fennel and Neovim. It
provides Clojure-like additions, like modules. It is used here to initialize my configurations.
Enable Aniseed's configuration runtime environment.


# init.fnl

```fennel
(module init {require-macros [katcros-fnl.macros.nvim.api.utils.macros
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

- [Autocommands](#fnlaufnl)
- [System-wide Configs](#fnlconfigfnl)
- [Maps](#fnlmapsfnl)
- [System-wide variables](#fnlsystemfnl)


## Plugins


```fennel
(def plugins [])
```

Here we are defining a sequential table of plugins that can be loaded by lazy.nvim later. This
is done for easier management of all the plugins.


### Bootstrapped Plugins

```fennel
(table.insert plugins :folke/lazy.nvim)
(table.insert plugins :Olical/aniseed)
(table.insert plugins {:dir "~/Repos/NEOVIM/katcros-fnl/"})
```

These are the plugins we loaded in with the [bootstrap](#bootstrapping), they're updated with
lazy.nvim.



### Treesitter

```fennel
(table.insert plugins {1 :nvim-treesitter/nvim-treesitter
                       :build ":TSUpdate"
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
(table.insert plugins {:url :https://gitlab.com/HiPhish/nvim-ts-rainbow2
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

``` fennel
(table.insert plugins {1 :nvim-treesitter/nvim-tree-docs
                       :config (fn [] (require :plugins.treesitter.docs.config))})
```

[nvim-tree-docs](https://github.com/nvim-treesitter/nvim-tree-docs) creates docs for supported
languages. Currently don't use.

``` fennel
(table.insert plugins {1 :SmiteshP/nvim-gps
                       :config (fn [] (require :plugins.nvim-gps.config))})
```

[nvim-gps](https://github.com/SmiteshP/nvim-gps) shows position in statusline. Currently don't
use.

```fennel
(table.insert plugins {1 :folke/todo-comments.nvim
                       :config (fn [] (require :plugins.todo-comments.config))})
```

[todo-comments.nvim](https://github.com/folke/todo-comments.nvim) highlights common comment
strings such as 'TODO'



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
(table.insert plugins {:dir "~/Repos/NEOVIM/katdotnvim/"
                       :config (fn [] 
                                 (if (= sys.name :builder)
                                     (do
                                       (set-opts {:background :light
                                                  :termguicolors true})
                                       (vim.cmd.colorscheme "kat.nvim"))
                                     (do
                                       (set-opt :termguicolors true)
                                       ((. (require :plugins.colors.time) :set-colors))
                                       ((. (require :plugins.colors.scheme) :set*)))))})
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

``` fennel
(table.insert plugins {:dir "~/Repos/NEOVIM/vim-startify/"
                       :config (fn [] (require :plugins.startify.config))})
```

[vim-startify](https://github.com/mhinz/vim-startify) is a start-page plugin.

```fennel
(table.insert plugins {:dir "~/Repos/NEOVIM/nvim-startify/"})
```

[nvim-startify](https://github.com/katawful/nvim-startify) is a Neovim recreation of vim-startify

```fennel
(table.insert plugins {1 :gelguy/wilder.nvim
                       :build ":UpdateRemotePlugins"
                       :config (fn [] (require :plugins.wilder.config))})
```

[wilder.nvim](https://github.com/gelguy/wilder.nvim) is a completion plugin for command-line and
search.

```fennel
(table.insert plugins {:dir "~/Repos/NEOVIM/syntax-test"})
```

This is a tiny syntax plugin for me to look at various hl groups. It's only installed with
lazy.nvim to make management easier.

```fennel
(table.insert plugins {:dir "~/Repos/NEOVIM/kreative"})
```

[Kreative](https://github.com/katawful/kreative) is a 16 color GUI colorscheme generator plugin
that I made.

```fennel
(table.insert plugins :nanozuki/tabby.nvim)
```

[tabby.nvim](https://github.com/nanozuki/tabby.nvim) is a tabline plugin.

``` fennel
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
                       :build (let [path (.. (do-viml stdpath :data) :/lazy/parinfer-rust)]
                                (string.format "(cd %s; cargo build --release)"
                                               path))})
```

[parinfer-rust](https://github.com/eraserhd/parinfer-rust) is a rust based parinfer plugin for
LISPs. Requires `cargo` to be installed.

```fennel
(table.insert plugins {1 :lervag/vimtex
                       :config (fn [] (require :plugins.latex.config))})
```

[VimTeX](https://github.com/lervag/vimtex) is a LaTeX filetype plugin.

```fennel
(table.insert plugins {:dir "~/Repos/OBLIVION/obl.vim"})
```

[obse.vim](https://github.com/katawful/obse.vim) is a syntax plugin for Oblivion.

```fennel
(table.insert plugins {:dir "~/Repos/OBLIVION/obluavim"})
```

[obluavim](https://github.com/katawful/obluavim) is my in-progress filetype plugin for Oblivion.

```fennel
(table.insert plugins {1 :katawful/Obli-Vim-Docs
                       :ft :obl})
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

```fennel
(table.insert plugins {1 :IndianBoy42/fuzzy.nvim
                       :dependencies [{1 :nvim-telescope/telescope-fzf-native.nvim
                                       :build "make"}]})
(table.insert plugins {1 :IndianBoy42/fuzzy_slash.nvim
                       :opts {:Fz :Fuz
                              :FzNext :FuzNext
                              :FzPrev :FuzPrev
                              :FzPattern :FuzPattern
                              :FzClear :FuzClear}})
```

[fuzzy_slash](https://github.com/IndianBoy42/fuzzy_slash.nvim) is a fuzzy single buffer search
plugin.


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
                       :build (fn [] (let [path (.. (do-viml stdpath :data) :/lazy/fzf)
                                           install (.. path "/install")]
                                       (do-viml system [install "--all"])))})
```

[FZF](https://github.com/junegunn/fzf) is a command-line fuzzy finder.

```fennel
(table.insert plugins {:dir "~/Repos/NEOVIM/dirbuf.nvim"
                       :config (fn [] (require :plugins.dirbuf.config))})
```

[dirbuf.nvim](https://github.com/elihunter173/dirbuf.nvim) is a dired-like file manager.

```fennel
(table.insert plugins {1 :ibhagwan/fzf-lua
                       :config (fn [] (require :plugins/fzf/config))})
```

[fzf-lua](https://github.com/ibhagwan/fzf-lua) is a binding for FZF.

```fennel
(table.insert plugins :airblade/vim-rooter)
```

[vim-rooter](https://github.com/airblade/vim-rooter) is a root directory finder/manager.

``` fennel
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
                       :build ":Neorg sync-parsers"
                       :config (fn [] (require :plugins.neorg.config))
                       :dependencies [:nvim-lua/plenary.nvim]})
```

``` fennel
(table.insert plugins {:dir "~/Repos/NEOVIM/neorg/"
                       :build ":Neorg sync-parsers"
                       :config (fn [] (require :plugins.neorg.config))
                       :dependencies [:nvim-lua/plenary.nvim]})
```

[Neorg](https://github.com/nvim-neorg/neorg) is a markup language and organization plugin.


## lazy.nvim Call

```fennel
((. (require :lazy) :setup) [plugins])
(require :plugins.lazy.config)
```

Here we call `lazy.nvim`. We iterate over the table `plugins` to load each plugin, and also set
the configs desired for `lazy.nvim` itself.


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


## Internal Plugin Loading

``` fennel
(require :plugins.session.init)
```

Some internal config plugins cannot be loaded implicitly, so they must be loaded last.


## Tabby Call

```fennel
(require :plugins.tabby.config)
```

Tabby.nvim needs to be called separately due to a race condition.
