(module plugins.fnlfmt.format
         {autoload {curl plugins.fnlfmt.curl}})

;;; Formatting

(defn config-files []
  "Get config fennel files"
  (let [files (vim.api.nvim_get_runtime_file "**/*.fnl" true)
        config-dir (.. vim.env.HOME "/.config/nvim/")
        fmt-table []]
    (each [_ v (pairs files)]
      (if (and (v:find config-dir)
               (not (v:find (.. vim.env.HOME "/.config/nvim/plugins/fnlfmt/fnlfmt.fnl"))))
        (table.insert fmt-table v)))
    fmt-table))

(defn format []
  (if (and (= (curl.fnlfmt) 0) (= (curl.fennel-lua) 0))
    (let [fnlfmt (require :plugins.fnlfmt.fnlfmt)]
      (each [_ v (pairs (config-files))]
        (let [out-file (vim.loop.fs_open v :w+ 438)
              out-stat (vim.loop.fs_stat out-file)
              temp-file (vim.loop.fs_open (.. v "-bak") :w+ 438)]
          (temp-file:fs_write (out-file:fs_read out-stat 0))
          (local temp-stat (vim.loop.fs_stat temp-file))
          (print (temp-file:fs_read temp-stat 0))
          (temp-file:fs_unlink (.. v "-bak"))
          (out-file:fs_close)
          (temp-file:fs_close))))))
        ; (var contents "")
        ; (with-open [in-file (io.open v :r)]
        ;   (set contents (in-file:read :*all)))
        ; ; (let [temp-file (io.open (.. v "-bak") :w+)]
        ; (with-open [temp-file (io.open (.. v "-bak") :w+)]
        ;             ; out-file (io.open v :w)]
        ;   (temp-file:write contents)
        ;   (fnlfmt.format-file (.. v "-bak") {:no-comments :no-comments}))
        ;   ; (io.close temp-file))
        ;   ; (out-file:write (fnlfmt.format-file (.. v "-bak") {})))
        ; (vim.fn.system (.. "rm " v "-bak"))))))
