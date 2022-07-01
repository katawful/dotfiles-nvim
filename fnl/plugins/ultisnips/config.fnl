(module plugins.ultisnips.config
        {require-macros [katcros-fnl.macros.nvim.api.options.macros]})

;;; Configs for Ultisnips
;;; https://github.com/SirVer/ultisnips

(let- g :UltiSnipsExpandTrigger :<tab>)
(let- g :UltiSnipsJumpForwardTrigger :<tab>)
(let- g :UltiSnipsJumpBackwardsTrigger :<s-tab>)
