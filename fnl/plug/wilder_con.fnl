(module wilder_con
        {require-macros [macros]})

((. vim.fn :wilder#setup) {:modes {1 ":"
                                   2 "/"
                                   3 "?"
                                   }})
; ((. vim.fn :wilder#set_option) :renderer ((. vim.fn :wilder#popupmenu_renderer) ((. vim.fn :wilder#popupment_border_theme) {:highlights {:border :Normal} :border :rounded})))

(vim.cmd "
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({ 'highlights': {   'border': 'Normal', }, 'border': 'rounded', })))
         ")
