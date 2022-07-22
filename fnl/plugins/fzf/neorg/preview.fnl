(module plugins.fzf.neorg.previewer
  {autoload {preview plugins.fzf.preview
             neorg-config plugins.neorg.config
             configs plugins.fzf.configs
             a aniseed.core
             s aniseed.string}})

;;; Previewer for neorg

(defonce main-file :main.norg)

(def base (. (require :fzf-lua.previewer.builtin) :base))
(def buffer_or_file (. (require :fzf-lua.previewer.builtin) :buffer_or_file))

(def contents-type {})

;; output the module table explicitly
;; This is needed to get the preview window working
(def module-tab *module*)

(defn get-index [item] "Get index for current item" (preview.get-index* item))

(defn new [self o opts fzf-win] (preview.new* self o opts fzf-win))

(defn contents [] "Get Neorg workspaces"
      (let [output []]
        (each [name dir (pairs neorg-config.workspaces)]
          (table.insert output {:text name
                                :name name
                                :dir dir}))
        output))

(defn parse_entry [self entry-str] "Get content at specified index"
      (let [index (get-index entry-str)]
        (. (contents) index)))

(defn slurp [path] "Slurp a file"
  (a.slurp (.. path "/main.norg")))

(defn parse-data [path] "Get rid of newlines so it can be output"
      (s.split (slurp path) "\n"))

(defn data-length [data] "Find the length of the data"
      (local (_ output) (string.gsub data "\n" "")) output)

(defn populate_preview_buf [self entry-str]
      "Populate preview window with session information
Seems to be broken in kitty for some reason."
      (let [entry (self:parse_entry entry-str)]
        (vim.api.nvim_buf_call self.preview_bufnr
                               (fn []
                                 (vim.cmd (.. "edit " entry.dir "/main.norg"))
                                 (vim.cmd "redraw")))
        (self.win:update_scrollbar)))
