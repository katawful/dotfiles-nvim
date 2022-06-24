(module plugins.fnlfmt.format {autoload {curl plugins.fnlfmt.curl}})

;;; Formatting

(defn config-files [] "Get config fennel files"
      (let [files (vim.api.nvim_get_runtime_file :**/*.fnl true)
            config-dir (.. vim.env.HOME :/.config/nvim/)
            fmt-table []]
        (each [_ v (pairs files)]
          (if (and (v:find config-dir)
                   (not (v:find (.. vim.env.HOME
                                    :/.config/nvim/plugins/fnlfmt/fnlfmt.fnl))))
              (table.insert fmt-table v)))
        fmt-table))

(defn configs! [] "Compile configs properly" (curl.fnlfmt!))

(defn compile! [] (let [fnlfmt (require :plugins.fnlfmt.fnlfmt)]
                    (each [_ v (pairs (config-files))]
                      (let [out-file (assert (vim.loop.fs_open v :r+ 438)
                                             "something went wrong with fs_open")
                            temp-file (vim.loop.fs_open (.. v :-bak) :w+ 438)]
                        ; write to temp file with formated source file
                        (vim.loop.fs_write temp-file (fnlfmt.format-file v {})
                                           0)
                        (let [temp-stat (vim.loop.fs_fstat temp-file)] ; get rid of source file
                          (vim.loop.fs_unlink v)
                          (vim.loop.fs_close out-file) ; make temp file the source file and delete the temp file
                          (vim.loop.fs_rename (.. v :-bak) v)
                          (vim.loop.fs_unlink (.. v :-bak))
                          (vim.loop.fs_close temp-file))))))
