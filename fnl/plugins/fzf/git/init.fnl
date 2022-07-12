(module plugins.fzf.git.init
        {require-macros [katcros-fnl.macros.nvim.api.autocommands.macros
                         katcros-fnl.macros.nvim.api.maps.macros]})

;;; Handles manipulation of git stuff from fzf directly

;; FN -- open up a fugitive window in a floating window for quick checking
;; @dir -- the directory
(defn open$ [dir] "Opens a fugitive window of the directory desired"
      ; open up fugitive at the right di
      (vim.fn.chdir dir) (vim.cmd :Git)
      (let [timer (vim.loop.new_timer)
            fug-win (vim.api.nvim_get_current_win)
            fug-buf (vim.api.nvim_win_get_buf fug-win)
            ui (. (vim.api.nvim_list_uis) 1)
            width-pad (math.floor (/ ui.width 3.14))
            win-width (-> ui.width
                          (- width-pad))
            height-pad (math.floor (/ ui.height 3.14))
            win-height (-> ui.height
                           (- height-pad))
            win-opts {:relative :editor
                      :height win-height
                      :width win-width
                      :row (/ (- ui.height win-height) 2)
                      :col (/ (- ui.width win-width) 2)
                      :border :rounded
                      :style :minimal}] ; use a very small timer so things aren't poorly blocked
        (timer:start 1 0
                     (vim.schedule_wrap (fn []
                                          (nno- :q
                                                (fn []
                                                  (vim.api.nvim_win_close fug-win
                                                                          true))
                                                "Close fugitive window with just q"
                                                {:buffer fug-buf})
                                          (nno- :<Esc>
                                                (fn []
                                                  (vim.api.nvim_win_close fug-win
                                                                          true))
                                                "Close fugitive window with just <Esc>"
                                                {:buffer fug-buf})
                                          (let [fug-floatwin (def-aug- :fugitiveFloatwin)]
                                            (aug- fug-floatwin
                                                  (auc- :BufLeave nil
                                                        (fn []
                                                          (vim.api.nvim_win_close fug-win
                                                                                  true)
                                                          (vim.api.nvim_del_augroup_by_id fug-floatwin))
                                                        "Close fugitive floating window after we leave it"
                                                        {:buffer fug-buf})))
                                          (vim.api.nvim_win_set_config fug-win
                                                                       win-opts))))))
