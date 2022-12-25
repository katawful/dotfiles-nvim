(module plugins.neorg.config
        {autoload {sys system}
         require-macros [katcros-fnl.macros.lispism.macros]})

;;; Configs for Neorg
;;; https://github.com/nvim-neorg/neorg

;; String -- Leader for neorg
(def neorg_leader :<Leader>n)

;; Key -- Workspaces for neorg
(defonce workspaces
         {:blog (.. sys.home-path :/Documents/neorg/Blog)
          :fennel (.. sys.home-path :/Documents/neorg/Fennel)
          :oblivion (.. sys.home-path :/Documents/neorg/Oblivion)
          :personal (.. sys.home-path :/Documents/neorg/Personal)
          :programming (.. sys.home-path :/Documents/neorg/Programming)
          :obl-ref (.. sys.home-path "/Git Repos/oblivion-lang-ref")
          :wood (.. sys.home-path :/Documents/neorg/Woodworking)
          :config (.. sys.home-path :/.config/nvim/docs)})

(defonce norg-map {:n [[:gtd :core.norg.qol.todo_items.todo.task_done]
                       [:gtu :core.norg.qol.todo_items.todo.task_undone]
                       [:gtp :core.norg.qol.todo_items.todo.task_pending]
                       [:<C-Space> :core.norg.qol.todo_items.todo.task_cycle]
                       [:<CR> :core.norg.esupports.hop.hop-link]
                       ["{" :core.integrations.treesitter.next.heading]
                       ["}" :core.integrations.treesitter.previous.heading]
                       ["<Tab>" :core.integrations.treesitter.next.link]
                       ["<S-Tab>" :core.integrations.treesitter.previous.link]
                       [(.. neorg_leader :v) :core.gtd.base.views]
                       [(.. neorg_leader :c) :core.gtd.base.capture]
                       [(.. neorg_leader :e) :core.gtd.base.edit]
                       [(.. neorg_leader :N) :core.norg.dirman.new.note]]
                   :o [[:ah :core.norg.manoeuvre.textobject.around-heading]
                       [:ih :core.norg.manoeuvre.textobject.inner-heading]
                       [:at :core.norg.manoeuvre.textobject.around-tag]
                       [:it :core.norg.manoeuvre.textobject.inner-tag]
                       [:al :core.norg.manoeuvre.textobject.around-heading]]})

(defonce gtd-map {:n [[:<CR> :core.gtd.ui.goto_task]
                      [:q :core.gtd.ui.close]
                      [:<Esc> :core.gtd.ui.close]
                      [:e :core.gtd.ui.edit_task]
                      [:<Tab> :core.gtd.ui.details]]})

(defonce all-map {:n [[(.. neorg_leader :mn) "<cmd>Neorg mode norg<CR>"]
                      [(.. neorg_leader :mh)
                       "<cmd>Neorg mode traverse-heading<CR>"]]})

;; Setup -- setup table for neorg
(opt- :neorg :setup
      {:load {:core.defaults {}
              :core.norg.concealer {:config {:dim_code_blocks {:conceal false
                                                               :width :content
                                                               :content_only true
                                                               :adaptive true}}}
              :core.export {}
              :core.export.markdown {}
              :core.keybinds {:config {:neorg_leader :<Leader>n}}
              :core.norg.dirman {:config {: workspaces
                                          :index :main.norg
                                          :autodetect true
                                          :autochdir true}}
              :core.norg.qol.toc {}
              :core.norg.journal {:config {:workspace :personal
                                           :journal_folder :journal
                                           :use_folders false}}}
       :hook (fn []
               (let [neorg_callbacks (require :neorg.callbacks)]
                 (neorg_callbacks.on_event :core.keybinds.events.enable_keybinds
                                           (fn [_ content]
                                             (content.map_event_to_mode :norg norg-map
                                                                        {:silent true
                                                                         :noremap true})
                                             (content.map_event_to_mode :gtd-displays gtd-map
                                                                        {:silent true
                                                                         :noremap true
                                                                         :nowait true})
                                             (content.map_to_mode :all all-map
                                                                  {:silent true
                                                                   :noremap true})))))})
