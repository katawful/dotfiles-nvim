(module plugins.lsp.config
        {require-macros [katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.nvim.api.options.macros]})

;;; Configs for lsp

;; Seq -- sequential table of servers
(def servers [:clangd])

; :sumneko_lua])

(def lsp_installer (require :nvim-lsp-installer.servers))

(local runtime-path (vim.split package.path ";"))
(table.insert runtime-path :lua/?.lua)
(table.insert runtime-path :lua/?/init.lua)
(defn _G.install_servers []
      (each [_ lsp (pairs servers)]
        (local (server_is_found server) (lsp_installer.get_server lsp))
        (when (not (server:is_installed))
          (do
            (vim.notify (.. "Installing " lsp) vim.log.levels.INFO)
            (server:install)))
        (when server_is_found
          (server:on_ready (fn []
                             (let [opts {:on_attach on-attach
                                         :flags {:debounce_text_changes 150}}]
                               (when (= server.name :sumneko_lua)
                                 (set opts.settings
                                      {:Lua {:runtime {:version :LuaJIT
                                                       :path runtime-path}
                                             :workspace {:library (vim.api.nvim_get_runtime_file ""
                                                                                                 true)}
                                             :diagnostics {:globals {1 :vim}}}}))
                               (server:setup opts)))))))

;; Call maps
(require :plugins.lsp.maps)
