(module playground
        {require-macros [macros]})

(opt- nvim-treesitter.configs setup {
    :playground {
      :enable true
      :updatetime 205
      :persist_queries false
      :keybindings {
        :toggle_query_editor :o
        :toggle_hl_groups :i
        :toggle_injected_languages :t
        :toggle_anonymous_nodes :a
        :toggle_language_display :I
        :focus_language :f
        :unfocus_language :F
        :update :R
        :goto_node :<CR>
        :show_help "?" }
}})
