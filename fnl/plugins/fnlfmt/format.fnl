(module plugins.fnlfmt.format {autoload {curl plugins.fnlfmt.curl}})

;;; Formatting

;; String -- String of home directory root, i.e. /home/kat
;; vim.env calls vim.fn internally, which is incompatible with Lua callbacks without a defer
(def home-root vim.env.HOME)

;; Seq -- Sequential table of all fennel files within our runtime
(def fnl-runtime-files (vim.api.nvim_get_runtime_file :**/*.fnl true))

;; FN -- Get fennel configuration files only
(defn config-files [] "Get only the fennel configuration files"
      (let [files fnl-runtime-files
            config-dir (.. home-root :/.config/nvim/)
            fmt-table []]
        (each [_ v (pairs files)]
          (if (and (v:find config-dir)
                   (not (v:find (.. home-root
                                    :/.config/nvim/plugins/fnlfmt/fnlfmt.fnl))))
              (table.insert fmt-table v)))
        fmt-table))

;; Async Tree FN -- Starts the tree to format fennel configuration files
(defn configs! [] "Compile Neovim configs when inside Neovim directory
Runs plugins.fnlfmt.curl.fnlfmt!"
      (let [config-root (.. vim.env.HOME :/.config/nvim)
            current-dir (vim.loop.cwd)]
        (if (current-dir:find config-root)
            (curl.fnlfmt!)
            (vim.notify "Not in Neovim configuration directory, fnlfmt won't start"
                        vim.log.levels.ERROR))))

;; FN -- Formats configuration files
(defn compile! [] "Format Neovim configuration files"
      (let [fnlfmt (require :plugins.fnlfmt.fnlfmt)]
        (each [_ v (pairs (config-files))]
          (let [out-file (assert (vim.loop.fs_open v :r+ 438)
                                 "something went wrong with fs_open")
                temp-file (vim.loop.fs_open (.. v :-bak) :w+ 438)]
            (vim.loop.fs_write temp-file (fnlfmt.format-file v {}) 0) ; write to temp file with formated source file
            (vim.loop.fs_unlink v) ; get rid of source file
            (vim.loop.fs_close out-file)
            (vim.loop.fs_rename (.. v :-bak) v) ; make temp file the source file and delete the temp file
            (vim.loop.fs_unlink (.. v :-bak))
            (vim.loop.fs_close temp-file)))))

(defn file! [file] "Formats a specific file"
  (if (= (vim.fn.filereadable (.. vim.env.HOME
                                  "/.config/nvim/fnl/plugins/fnlfmt.fnlfmt.fnl"))
         1)
    (let [fnlfmt (require :plugins.fnlfmt.fnlfmt)
          old-file (vim.loop.fs_open file :r+ 438)
          temp-file (vim.loop.fs_open (.. file :-bak) :w+ 438)]
      (vim.loop.fs_write temp-file (fnlfmt.format-file file {}) 0)
      (vim.loop.fs_unlink file)
      (vim.loop.fs_close old-file)
      (vim.loop.fs_rename (.. file :-bak) v)
      (vim.loop.fs_unlink (.. file :-bak))
      (vim.loop.fs_close temp-file))
    (vim.notify "fnlfmt not found, no fixing implemented atm"
                vim.log.levels.ERROR)))
