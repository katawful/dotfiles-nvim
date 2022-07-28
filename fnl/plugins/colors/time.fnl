(module plugins.colors.time
  {autoload {scheme plugins.colors.scheme}})

;;; Handles autosetting of colors based on time of day

(defonce color (vim.loop.new_timer))

(defonce check (* 300 1000))

(defn set-colors []
  (color:start check check
               (vim.schedule_wrap (fn [] (scheme.set*)))))
