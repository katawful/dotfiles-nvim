(module plugins.fzf.git
  {require-macros [katcros-fnl.macros.nvim.api.autocommands.macros]})

;;; Handles manipulation of git stuff from fzf directly

;; FN -- open up a fugitive window in a floating window for quick checking
;; @dir -- the directory
(defn open$ [dir] "Opens a fugitive window of the directory desired"
  ; open up fugitive at the right di
  (vim.fn.chdir dir)
  (vim.cmd "Git")
  (let [timer (vim.loop.new_timer)
        fug-win (vim.api.nvim_get_current_win)
        fug-buf (vim.api.nvim_win_get_buf fug-win)
        ui (. (vim.api.nvim_list_uis) 1)
        win-width 90
        win-height 20
        win-opts {:relative :editor
                  :height win-height
                  :width win-width
                  :row (/ (- ui.height win-height) 2)
                  :col (/ (- ui.width win-width) 2)
                  :border :rounded
                  :style :minimal}]
    ; use a very small timer so things aren't poorly blocked
    (timer:start 1 0
      (vim.schedule_wrap
        (fn []
          (let [fug-floatwin (def-aug- "fugitiveFloatwin")]
            (aug- fug-floatwin
                  (auc- "BufLeave" nil
                        (fn [] (vim.api.nvim_win_close fug-win true))
                        "Close fugitive floating window after we leave it"
                        {:buffer fug-buf})))
          (vim.api.nvim_win_set_config fug-win win-opts))))))
