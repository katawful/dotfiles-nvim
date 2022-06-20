(module plugins.fnlfmt.curl {autoload {c aniseed.compile}})

;;; Download fnlfmt file via curl

(defn fnlfmt [] "Download fnlfmt into 'fnl/plugins/fnlfmt' with curl"
      (vim.fn.system "curl -o ~/.config/nvim/fnl/plugins/fnlfmt/fnlfmt.fnl \\
'https://git.sr.ht/~technomancy/fnlfmt/blob/main/fnlfmt.fnl'")
      (if (not= vim.v.shell_error 0)
          (vim.notify "Curl error, could not download fnlfmt.fnl"
                      vim.log.levels.ERROR)
          (c.file (.. vim.env.HOME :/.config/nvim/fnl/plugins/fnlfmt/fnlfmt.fnl)
                  (.. vim.env.HOME :/.config/nvim/lua/plugins/fnlfmt/fnlfmt.lua)))
      vim.v.shell_error)

(defn fennel-lua [] "Download fennel.lua into 'fnl/plugins/fnlfmt' with curl"
      (vim.fn.system "curl -o ~/.config/nvim/fnl/fennel.lua \\
'https://git.sr.ht/~technomancy/fnlfmt/blob/main/fennel.lua'")
      (if (not= vim.v.shell_error 0)
          (vim.notify "Curl error, could not download fennel.lua"
                      vim.log.levels.ERROR)
          (vim.fn.system (.. "cp "
                             (.. vim.env.HOME :/.config/nvim/fnl/fennel.lua) " "
                             (.. vim.env.HOME :/.config/nvim/lua/fennel.lua))))
      vim.v.shell_error)
