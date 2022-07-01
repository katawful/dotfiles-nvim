(module plugins.lsp.maps
        {require-macros [katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.nvim.api.options.macros]})

;;; Maps for lsp

(def nvim-lsp (require :lspconfig))
(defn on-attach [client bufnr] (set- omnifunc "v:lua.vim.lsp.omnifunc")
      (nno- :gD "<cmd>lua vim.lsp.buf.declaration()<CR>" {:silent true})
      (nno- :gd "<cmd>lua vim.lsp.buf.definition()<CR>" {:silent true})
      (nno- :K "<cmd>lua vim.lsp.buf.hover()<CR>" {:silent true})
      (nno- :gi "<cmd>lua vim.lsp.buf.implementation()<CR>" {:silent true})
      (nno- :<C-k> "<cmd>lua vim.lsp.buf.signature_help()<CR>" {:silent true})
      (nno- :<leader>wa "<cmd>lua vim.lsp.buf.add_workleader_folder()<CR>"
            {:silent true})
      (nno- :<leader>wr "<cmd>lua vim.lsp.buf.remove_workleader_folder()<CR>"
            {:silent true})
      (nno- :<leader>wl
            "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workleader_folders()))<CR>"
            {:silent true})
      (nno- :<leader>D "<cmd>lua vim.lsp.buf.type_definition()<CR>"
            {:silent true})
      (nno- :<leader>rn "<cmd>lua vim.lsp.buf.rename()<CR>" {:silent true})
      (nno- :<leader>ca "<cmd>lua vim.lsp.buf.code_action()<CR>" {:silent true})
      (nno- :gr "<cmd>lua vim.lsp.buf.references()<CR>" {:silent true})
      (nno- :<leader>E "<cmd>lua vim.diagnostic.open_float(0)<CR>"
            {:silent true})
      (nno- "[d" "<cmd>lua vim.diagnostic.goto_prev()<CR>" {:silent true})
      (nno- "]d" "<cmd>lua vim.diagnostic.goto_next()<CR>" {:silent true})
      (nno- :<leader>Q "<cmd>lua vim.diagnostic.set_loclist()<CR>"
            {:silent true})
      (nno- :<leader>F "<cmd>lua vim.lsp.buf.formatting()<CR>" {:silent true}))
