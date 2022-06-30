(module plugins.fnlfmt.curl
        {autoload {c aniseed.compile format plugins.fnlfmt.format}
         require-macros [katcros-fnl.macros.nvim.api.utils.macros]})

;; String -- String of home directory root, i.e. /home/kat
;; vim.env calls vim.fn internally, which is incompatible with Lua callbacks without a defer
(def- home-root vim.env.HOME)

;; FN -- Compile fnlfmt.fnl to fnlfmt.lua
;; Deferred
(defn- compile! [] "Compiles fnlfmt"
       (vim.schedule_wrap (fn []
                            (c.file (.. home-root
                                        :/.config/nvim/fnl/plugins/fnlfmt/fnlfmt.fnl)
                                    (.. home-root
                                        :/.config/nvim/lua/plugins/fnlfmt/fnlfmt.lua)))))

;; FN -- Copy fnl/fennel.lua to lua/fennel.lua
(defn- copy! [] "Copies fennel.lua to the lua directory"
       (vim.loop.fs_copyfile (.. home-root :/.config/nvim/fnl/fennel.lua)
                             (.. home-root :/.config/nvim/lua/fennel.lua)))

;; FN -- Error message if curl failed
(defn- error-message$ [file] "Error message for curling"
       (vim.notify (.. "Something went wrong with curling " file)
                   vim.log.levels.ERROR))

;; FN -- Asynchronously curl fennel.lua for runtime usage
(defn fennel-lua! [] "Download fennel.lua into 'fnl/' with curl.
Copies fnl/fennel.lua to lua/fennel.lua.
Runs format.configs on completion.
Callback has a nested function so we can vim.schedule_wrap important pieces.
Otherwise we couldn't run vim.fn functions."
      (let [fennel-dir (.. home-root :/.config/nvim/fnl/fennel.lua)
            fennel-url "https://git.sr.ht/~technomancy/fnlfmt/blob/main/fennel.lua"]
        (local handle
               (vim.loop.spawn :curl {:args [:-o fennel-dir fennel-url]}
                               (fn [code signal]
                                 (fn nest [signal]
                                   (if (> signal 0)
                                       (error-message$ :fennel.lua)
                                       (do
                                         (copy!)
                                         (handle:close)
                                         (format.compile!))))

                                 (vim.schedule_wrap (nest code)))))))

;; FN -- Asynchronously curl fnlfmt for formatting fennel files
(defn fnlfmt! [] "Download fnlfmt into 'fnl/plugins/fnlfmt' with curl.
Compiles fnlfmt.fnl to fnlfmt.lua.
Runs function fennel-lua on completion.
Callback has a nested function so we can vim.schedule_wrap important pieces.
Otherwise we couldn't run vim.fn functions."
      (let [fnlfmt-dir (.. home-root
                           :/.config/nvim/fnl/plugins/fnlfmt/fnlfmt.fnl)
            fnlfmt-url "https://git.sr.ht/~technomancy/fnlfmt/blob/main/fnlfmt.fnl"]
        (local handle
               (vim.loop.spawn :curl {:args [:-o fnlfmt-dir fnlfmt-url]}
                               (fn [code signal]
                                 (fn nest [signal]
                                   (if (> signal 0)
                                       (error-message$ :fnlfmt.fnl)
                                       (do
                                         (compile!)
                                         (handle:close)
                                         (fennel-lua!))))

                                 (vim.schedule_wrap (nest code)))))))
