(module plugins.neorg.config
        {autoload {sys system}
         require-macros [katcros-fnl.macros.lispism.macros]})

;;; Configs for Neorg
;;; https://github.com/nvim-neorg/neorg

;; String -- Leader for neorg
(def neorg_leader :<LocalLeader>n)

;; Key -- Workspaces for neorg
(defonce workspaces
         {:blog (.. sys.home-path :/Documents/neorg/Blog)
          :fennel (.. sys.home-path :/Documents/neorg/Fennel)
          :oblivion (.. sys.home-path :/Documents/neorg/Oblivion)
          :personal (.. sys.home-path :/Documents/neorg/Personal)
          :programming (.. sys.home-path :/Documents/neorg/Programming)
          :obl-ref (.. sys.home-path "/Repos/OBLIVION/oblivion-lang-ref")
          :wood (.. sys.home-path :/Documents/neorg/Woodworking)
          :academics (.. sys.home-path :/Documents/neorg/Academics)
          :config (.. sys.home-path :/.config/nvim/docs)})

(defonce norg-map {:n [[:gtd :core.qol.todo_items.todo.task_done]
                       [:gtu :core.qol.todo_items.todo.task_undone]
                       [:gtp :core.qol.todo_items.todo.task_pending]
                       [:<C-Space> :core.qol.todo_items.todo.task_cycle]
                       [:<CR> :core.esupports.hop.hop-link]
                       ["{" :core.integrations.treesitter.next.heading]
                       ["}" :core.integrations.treesitter.previous.heading]
                       ["<Tab>" :core.integrations.treesitter.next.link]
                       ["<S-Tab>" :core.integrations.treesitter.previous.link]
                       [(.. neorg_leader :n) :core.dirman.new.note]]
                   :o [[:ah :core.manoeuvre.textobject.around-heading]
                       [:ih :core.manoeuvre.textobject.inner-heading]
                       [:at :core.manoeuvre.textobject.around-tag]
                       [:it :core.manoeuvre.textobject.inner-tag]
                       [:al :core.manoeuvre.textobject.around-heading]]})

(defonce gtd-map {:n [[:<CR> :core.gtd.ui.goto_task]
                      [:q :core.gtd.ui.close]
                      [:<Esc> :core.gtd.ui.close]
                      [:e :core.gtd.ui.edit_task]
                      [:<Tab> :core.gtd.ui.details]]})

(defonce all-map {:n [[(.. neorg_leader :mn) "<cmd>Neorg mode norg<CR>"]
                      [(.. neorg_leader :mh)
                       "<cmd>Neorg mode traverse-heading<CR>"]]})

; require('neorg').setup {
;                         load = {
;                                 ['core.defaults'] = {},
;                                 ['core.completion'] = { config = { engine = 'nvim-cmp' } },
;                                 ['core.dirman'] = { config = { workspaces = { journal = '~/journal', rrc = '~/RRC' } } },
;                                 ['core.esupports.metagen'] = {
;                                                               config = {
;                                                                         tab = '  ',
;                                                                         template = {
; { 'title', function() return vim.fn.expand '%:t:r' end },
; { 'description', '' },
; { 'author', 'dasu pradyumna' },
; { 'categories', '' },
; { 'created', function() return os.date '%d %b %Y %H:%M' end },
; { 'updated', function() return os.date '%d %b %Y %H:%M' end },
; -- { 'version', require('neorg.config').norg_version }, -- error here, why?
;                                                                         ,
;update_date = false, -- BUG: "update-metadata" uses default datetime format (not config)}
;                                                               ,}
;                                 ,}
;                         ,}

(def- template  {:updated (fn [] (os.date "%d %b %Y %H:%M"))
                 :created (fn [] (os.date "%b %Y %H:%M"))
                 :title (fn [] (vim.fn.expand "%:t:r"))
                 :description ""
                 :author "Kat"
                 :categories ""
                 :update_data true})

;; Setup -- setup table for neorg
(opt- :neorg :setup
      {:load {:core.defaults {}
              :core.concealer {:config {:dim_code_blocks {:conceal false
                                                           :width :content
                                                           :content_only true
                                                           :adaptive true}}}
              ; :core.esupports.metagen {:config {: template}}
              :core.export {}
              :core.syntax {}
              :core.export.markdown {}
              ; :core.tempus {}
              ; :core.ui {}
              :core.summary {}
              ; :core.ui.calendar {}
              :core.keybinds {:config {:neorg_leader :<Leader>n}}
              :core.dirman {:config {: workspaces
                                          :index :main.norg
                                          :autodetect true
                                          :autochdir true}}
              :core.qol.toc {}
              :core.journal {:config {:workspace :personal
                                      :journal_folder :journal
                                      :use_folders false}}}})
       ; :hook (fn []
       ;         (let [neorg_callbacks (require :neorg.callbacks)]
       ;           (neorg_callbacks.on_event :core.keybinds.events.enable_keybinds
       ;                                     (fn [_ content]
       ;                                       (content.map_event_to_mode :norg norg-map
       ;                                                                  {:silent true
       ;                                                                   :noremap true})
       ;                                       (content.map_event_to_mode :gtd-displays gtd-map
       ;                                                                  {:silent true
       ;                                                                   :noremap true
       ;                                                                   :nowait true})
       ;                                       (content.map_to_mode :all all-map
       ;                                                            {:silent true
       ;                                                             :noremap true})))))})

(require :plugins.neorg.maps)
