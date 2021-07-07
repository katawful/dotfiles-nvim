(module vimwiki
        {require-macros [macros]})

(nno- :<leader>W<leader>W ":VimwikiDiaryIndex<CR>")

(let- g :vimwiki_list
  {1 {:path "~/Documents/VimWikiHTML/VimWiki"
      :path_html "~/Documents/VimWikiHTML"
      :auto_generate_links 1
      :auto_export 1}})
; (let- g :vimwiki_nested_syntaxes
;   {1 {:python :python}
;    2 {:c++ :c++}
;    3 {:xml :xml}})

(let- g :vimwiki_folding :list)
(let- g :vimwiki_listsyms "◯◔◐◕●✓")
(let- g :vimwiki_global_ext 0)
(let- g :vimwiki_conceallevel 2)
