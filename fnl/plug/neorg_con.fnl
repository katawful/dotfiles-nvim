(module neorg_con
        {require-macros [macros]})

(def neorg_leader :<Leader>n)
(opt- neorg setup
      {:load {:core.defaults {}
              :core.norg.concealer {:config {:markup_preset :dimmed
                                             }}
              :core.keybinds {:config {:neorg_leader :<Leader>n}}
              :core.norg.dirman {:config
                                 {:workspaces
                                  {:blog "~/Documents/neorg/Blog"
                                   :fennel "~/Documents/neorg/Fennel"
                                   :oblivion "~/Documents/neorg/Oblivion"
                                   :personal "~/Documents/neorg/Personal"
                                   :programming "~/Documents/neorg/Programming"
                                   :wood "~/Documents/neorg/Woodworking"}
                                  :index "main.norg"
                                  :autodetect true
                                  :autochdir true}}
              :core.gtd.base {:config {:workspace :programming}}
              :core.norg.qol.toc {}
              :core.norg.journal {:config {:workspace :personal
                                           :journal_folder "journal"
                                           :use_folders false
                                           }}
              :core.norg.completion {:config {:engine :nvim-cmp}}
              }
        :hook (fn []
         (local neorg_callbacks (require :neorg.callbacks))
         (neorg_callbacks.on_event :core.keybinds.events.enable_keybinds 
           (fn [_ content]
             ; (when (= content.mode "special-mode")
             ;   (content.map :n :<C-s> ":w<CR>" {:silent true}))
             ; (content.map_to_mode :special-mode 
             ;                      {
             ;                       :n {1 {1 :<C-s>
             ;                              2 ":w<CR>"}}}
             ;                      {:silent true})
             (content.map_event_to_mode :norg
              {:n {1 {1 :gtd
                      2 :core.norg.qol.todo_items.todo.task_done}
                   2 {1 :gtu
                      2 :core.norg.qol.todo_items.todo.task_undone}
                   3 {1 :gtp
                      2 :core.norg.qol.todo_items.todo.task_pending}
                   4 {1 :<C-Space>
                      2 :core.norg.qol.todo_items.todo.task_cycle}
                   5 {1 :<CR>
                      2 :core.norg.esupports.hop.hop-link}
                   6 {1 "[["
                      2 :core.integrations.treesitter.next.heading}
                   7 {1 "]]"
                      2 :core.integrations.treesitter.previous.heading}
                   6 {1 "{{"
                      2 :core.norg.manoeuvre.item_up}
                   7 {1 "}}"
                      2 :core.norg.manoeuvre.item_down}
                   8 {1 (.. neorg_leader "v")
                      2 :core.gtd.base.views}
                   9 {1 (.. neorg_leader "c")
                      2 :core.gtd.base.capture}
                   10 {1 (.. neorg_leader "e")
                       2 :core.gtd.base.edit}
                   11 {1 (.. neorg_leader :N)
                       2 :core.norg.dirman.new.note}
                   }
               :o {1 {1 :ah
                      2 :core.norg.manoeuvre.textobject.around-heading}
                   2 {1 :ih
                      2 :core.norg.manoeuvre.textobject.inner-heading}
                   3 {1 :at
                      2 :core.norg.manoeuvre.textobject.around-tag}
                   4 {1 :it
                      2 :core.norg.manoeuvre.textobject.inner-tag}
                   5 {1 :al
                      2 :core.norg.manoeuvre.textobject.around-heading}
                   }
               }
              {:silent true
               :noremap true})
             (content.map_event_to_mode :gtd-displays
              {:n {1 {1 :<CR>
                      2 :core.gtd.ui.goto_task}
                   2 {1 :q
                      2 :core.gtd.ui.close}
                   3 {1 :<Esc>
                      2 :core.gtd.ui.close}
                   4 {1 :e
                      2 :core.gtd.ui.edit_task}
                   5 {1 :<Tab>
                      2 :core.gtd.ui.details}
                   }}
              {:silent true
               :noremap true
               :nowait true})
             (content.map_to_mode :all
              {:n {1 {1 (.. neorg_leader :mn)
                      2 ":Neorg mode norg<CR>"}
                   2 {1 (.. neorg_leader :mh)
                      2 ":Neorg mode traverse-heading<CR>"}
                   }}
              {:silent true
               :noremap true
               })
             )))})
; (opt- neorg setup 
;       {:load {:core.defaults {}
;               :core.norg.concealer {:config {:markup_preset :safe}}
;               :core.norg.dirman {:config {:workspaces {:main "~/Documents/neorg"}
;                                           :autodetect true
;                                           :autochdir true}}
;               }}
;       )
; (vim.cmd "NeorgStart silent=true")
