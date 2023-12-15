(module plugins.ultisnips.config
        {require-macros [katcros-fnl.macros.nvim.api.options.macros]})

;;; Configs for Ultisnips
;;; https://github.com/SirVer/ultisnips

(set-vars g {:UltiSnipsExpandTrigger :<tab>
             :UltiSnipsJumpForwardTrigger :<tab>
             :UltiSnipsEditSplit :context
             :UltiSnipsJumpBackwardsTrigger :<s-tab>})
