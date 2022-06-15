(module plugins.fzf.preview
  {autoload {repos plugins.git.repos
             s aniseed.string}})

(def base (. (require :fzf-lua.previewer.builtin) :base))
(def buffer_or_file (. (require :fzf-lua.previewer.builtin)
                       :buffer_or_file))

;; output the module table explicitly
;; This is needed to get the preview window working
(def module-tab *module*)

(defn get-index [item] "Get index for current item"
  (tonumber (item:match "^[(%d)]")))

(defn new [self o opts fzf-win]
  (set-forcibly! self
                 (setmetatable (base o opts fzf-win)
                               {:__index (vim.tbl_deep_extend :keep self
                                                              base)}))
  self)


;; FN -- output a table of contents appropriately
;; This is needed to minimize how much work is needed to change things
(defn contents [] "Contents to parse"
  (let [dirs (repos.directories repos.dotfiles)
        output []]
    (each [_ v (ipairs dirs)]
      (table.insert output {:text v
                            :data (repos.status v)}))
    output))

(defn parse_entry [self entry-str] "Get content at specified index"
  (let [index (get-index entry-str)]
    (. (contents) index)))

(defn parse-data [data] "Get rid of newlines so it can be output"
  (s.split data "\n"))

(defn data-length [data] "Find the length of the data"
  (local (_ output) (string.gsub data "\n" ""))
  output)

(defn populate_preview_buf [self entry-str] "Populate the preview window"
  (let [entry (self:parse_entry entry-str)
        data (parse-data entry.data)
        line-count (data-length entry.data)]
    (set self.preview_bufloaded true)
    (vim.api.nvim_buf_set_lines self.preview_bufnr 0 line-count false data)
    ; (local filetype :git)
    ; (vim.api.nvim_buf_set_option self.preview_bufnr :filetype filetype)
    (self.win:update_scrollbar)))