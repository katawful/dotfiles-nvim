(module plugins.lsp.config
        {autoload {maps plugins.lsp.maps
                   sys system}
         require-macros [katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.lispism.macros]})

;;; Configs for lsp

;; Seq -- sequential table of servers
(def servers [:clangd])

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

(opt- :mason :setup)

(opt- :mason-lspconfig :setup {:ensure_installed [:zls]})

((. (. (require :lspconfig) :zls) :setup) 
 {:on_attach maps.on-attach
  :settings {:zls {:enable_unused_variable_warnings true
                   :enable_inlay_hints true
                   :zig_lib_path (.. sys.home-path "/.local/bin/ziglang/zig/lib")
                   :zig_exe_path (.. sys.home-path "/.local/bin/ziglang/zig")}}})

;; Call maps
; (require :plugins.lsp.maps)
