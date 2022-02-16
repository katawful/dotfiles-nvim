(module lspconfig_con
        {require-macros [macros]})

(def nvim-lsp (require :lspconfig))
(defn on-attach [client bufnr]
  (set- omnifunc "v:lua.vim.lsp.omnifunc")
  (nno- :gD "<cmd>lua vim.lsp.buf.declaration()<CR>" :silent)
  (nno- :gd "<cmd>lua vim.lsp.buf.definition()<CR>" :silent)
  (nno- :K "<cmd>lua vim.lsp.buf.hover()<CR>" :silent)
  (nno- :gi "<cmd>lua vim.lsp.buf.implementation()<CR>" :silent)
  (nno- :<C-k> "<cmd>lua vim.lsp.buf.signature_help()<CR>" :silent)
  (nno- :<leader>wa "<cmd>lua vim.lsp.buf.add_workleader_folder()<CR>" :silent)
  (nno- :<leader>wr "<cmd>lua vim.lsp.buf.remove_workleader_folder()<CR>" :silent)
  (nno- :<leader>wl "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workleader_folders()))<CR>" :silent)
  (nno- :<leader>D "<cmd>lua vim.lsp.buf.type_definition()<CR>" :silent)
  (nno- :<leader>rn "<cmd>lua vim.lsp.buf.rename()<CR>" :silent)
  (nno- :<leader>ca "<cmd>lua vim.lsp.buf.code_action()<CR>" :silent)
  (nno- :gr "<cmd>lua vim.lsp.buf.references()<CR>" :silent)
  (nno- :<leader>E "<cmd>lua vim.diagnostic.open_float(0)<CR>" :silent)
  (nno- "[d" "<cmd>lua vim.diagnostic.goto_prev()<CR>" :silent)
  (nno- "]d" "<cmd>lua vim.diagnostic.goto_next()<CR>" :silent)
  (nno- :<leader>Q "<cmd>lua vim.diagnostic.set_loclist()<CR>" :silent)
  (nno- :<leader>F "<cmd>lua vim.lsp.buf.formatting()<CR>" :silent))

(def servers [
              :clangd
              :sumneko_lua
              ])
(def lsp_installer (require :nvim-lsp-installer.servers))

(local runtime-path (vim.split package.path ";"))
(table.insert runtime-path :lua/?.lua)
(table.insert runtime-path :lua/?/init.lua)
(defn install_servers []
  (each [_ lsp (pairs servers)]
    (local (server_is_found server) (lsp_installer.get_server lsp))
    (when server_is_found
      (server:on_ready (fn []
                         (let [opts {:on_attach on-attach
                                     :flags {:debounce_text_changes 150}}]
                           (when (= server.name :sumneko_lua)
                             (print "lua")
                             (set opts.settings {:Lua {:runtime {:version :LuaJIT
                                                                 :path runtime-path}
                                                       :workspace {:library (vim.api.nvim_get_runtime_file "" true)}
                                                       :diagnostics {:globals {1 :vim}}}}))
                         (server:setup_lsp opts)))))
  (when (not (server:is_installed))
    (vim.notify (.. "Installing " lsp) vim.log.levels.INFO)
    (server:install))))

(install_servers)
