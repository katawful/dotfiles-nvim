(module plugins.fnlfmt.curl
        {autoload {c aniseed.compile format plugins.fnlfmt.format}})

;;; Download fnlfmt file via curl

(defn- compile! [] "Compiles fnlfmt"
       (c.file (.. vim.env.HOME :/.config/nvim/fnl/plugins/fnlfmt/fnlfmt.fnl)
               (.. vim.env.HOME :/.config/nvim/lua/plugins/fnlfmt/fnlfmt.lua)))

(defn- copy! [] "Copies fennel.lua to the right directories"
       (vim.loop.fs_copyfile (.. vim.env.HOME :/.config/nvim/fnl/fennel.lua)
                             (.. vim.env.HOME :/.config/nvim/lua/fennel.lua)))

(defn- error-message$ [file] "Error message for curling"
       (vim.notify (.. "Something went wrong with curling " file)
                   vim.log.levels.ERROR))

(defn fennel-lua! [] "Download fennel.lua into 'fnl/' with curl
Runs format.configs on completion"
      (let [fennel-dir "~/.config/nvim/fnl/fennel.lua"
            fennel-url "https://git.sr.ht/~technomancy/fnlfmt/blob/main/fennel.lua"]
        (local handle
               (vim.loop.spawn :curl {:args [:-o fnlfmt-dir fnlfmt-url]}
                               ; need to wrap because vim.fn is called
                               (vim.schedule_wrap (fn [code signal]
                                                    (if (not= signal 0)
                                                        (error-message$ :fennel.lua)
                                                        (do
                                                          (copy!)
                                                          (handle:close)
                                                          (format.compile!)))))))))

(defn fnlfmt! [] "Download fnlfmt into 'fnl/plugins/fnlfmt' with curl
Runs function fennel-lua on completion"
      (let [fnlfmt-dir (.. vim.env.HOME
                           :/.config/nvim/fnl/pluins/fnlfmt/fnlfmt.fnl)
            fnlfmt-url "https://git.sr.ht/~technomancy/fnlfmt/blob/main/fnlfmt.fnl"]
        (local handle
               (vim.loop.spawn :curl {:args [:-o fnlfmt-dir fnlfmt-url]}
                               ; need to wrap because vim.fn is called
                               (vim.schedule_wrap (fn [code signal]
                                                    (if (not= signal 0)
                                                        (error-message :fnlfmt.fnl)
                                                        (do
                                                          (compile!)
                                                          (handle:close)
                                                          (fennel-lua!)))))))))
