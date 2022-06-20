(module plugins.fnlfmt.format
         {autoload {curl plugins.fnlfmt.curl}})

;;; Formatting

(defn config-files []
  "Get config fennel files"
  (let [files (vim.api.nvim_get_runtime_file "**/*.fnl" true)
        config-dir (.. vim.env.HOME "/.config/nvim/")
        fmt-table []]
    (each [_ v (pairs files)]
      (if (v:find config-dir)
        (table.insert fmt-table v)))
    fmt-table))

(defn format []
  (if (and (= curl.fnlfmt 0) (= curl.fennel-lua))
    (let [fnlfmt (require :plugins.fnlfmt.fnlfmt)]
      (each [_ v (pairs (config-files))]
        (var contents "")
        (with-open [in-file (io.open v :r)]
          (set contents (in-file:read :*all)))
        (with-open [temp-file (io.open (.. v "-bak") :w+)
                    out-file (io.open v :w)]
          (temp-file:write contents)
          (out-file:write (fnlfmt.format-file (.. v "-bak") {})))
        (vim.fn.system (.. "rm " v "-bak"))))))
