(module plugins.lsp.maps
        {require-macros [katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.nvim.api.options.macros]})

;;; Maps for lsp

(def nvim-lsp (require :lspconfig))
(defn on-attach [client bufnr] (set- omnifunc "v:lua.vim.lsp.omnifunc")
      (nno- :gD vim.lsp.buf.declaration {:silent true})
      (nno- :gd vim.lsp.buf.definition {:silent true})
      (nno- :K vim.lsp.buf.hover {:silent true})
      (nno- :gi vim.lsp.buf.implementation {:silent true})
      (nno- :<C-k> vim.lsp.buf.signature_help {:silent true})
      (nno- :<leader>wa vim.lsp.buf.add_workspace_folder
            {:silent true})
      (nno- :<leader>wr vim.lsp.buf.remove_workspace_folder
            {:silent true})
      (nno- :<leader>wl
            (fn [] (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
            {:silent true})
      (nno- :<leader>D vim.lsp.buf.type_definition
            {:silent true})
      (nno- :<leader>rn vim.lsp.buf.rename {:silent true})
      (nno- :<leader>ca vim.lsp.buf.code_action {:silent true})
      (nno- :gr vim.lsp.buf.references {:silent true})
      (nno- :<leader>E (fn [] (vim.diagnostic.open_float 0))
            {:silent true})
      (nno- "[d" vim.diagnostic.goto_prev {:silent true})
      (nno- "]d" vim.diagnostic.goto_next {:silent true})
      (nno- :<leader>Q vim.diagnostic.setloclist
            {:silent true})
      (nno- :<leader>F vim.lsp.buf.formatting {:silent true}))
