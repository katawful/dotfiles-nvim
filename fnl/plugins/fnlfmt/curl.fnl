(module plugins.fnlfmt.curl)

;;; Download fnlfmt file via curl

(defn fnlfmt []
  "Download fnlfmt into 'fnl/plugins/fnlfmt' with curl"
  (vim.fn.system 
    "curl -o ~/.config/nvim/fnl/plugins/fnlfmt/fnlfmt.fnl \\
'https://git.sr.ht/~technomancy/fnlfmt/blob/main/fnlfmt.fnl'")
  (if (not= vim.v.shell_error 0)
    (vim.notify "Curl error, could not download fnlfmt.fnl" vim.log.levels.ERROR)))
