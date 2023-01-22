(module plugins.fzf.git.preview
        {autoload {repos plugins.git.repos
                   preview plugins.fzf.preview
                   s aniseed.string}})

;;; preview module specific to git operations

(def base (. (require :fzf-lua.previewer.builtin) :base))
(def buffer_or_file (. (require :fzf-lua.previewer.builtin) :buffer_or_file))

;; A mutable table to determine what dir we are working on
(def repo-type {})

;; output the module table explicitly
;; This is needed to get the preview window working
(def module-tab *module*)

(defn get-index [item] "Get index for current item" (preview.get-index* item))

(defn new [self o opts fzf-win] (preview.new* self o opts fzf-win))

;; FN -- output a table of contents appropriately
;; This is needed to minimize how much work is needed to change things
(defn contents [] "Contents to parse"
      (let [dirs repo-type.current ; look at current repo type for dirs
            output []]
        (each [k v (pairs dirs)]
          (table.insert output {:text v.name
                                :data (repos.status v.dir)
                                :dir v.dir
                                :desc v.desc}))
        output))

(defn parse_entry [self entry-str] "Get content at specified index"
      (let [index (get-index entry-str)]
        (. (contents) index)))

(defn parse-data [data] "Get rid of newlines so it can be output"
      (if data
          (s.split data "\n")
          [""]))

(defn data-length [data] "Find the length of the data"
      (local (_ output) (string.gsub data "\n" "")) output)

(defn populate_preview_buf [self entry-str] "Populate the preview window"
      (let [entry (self:parse_entry entry-str)
            data (parse-data entry.data)
            ;; Set the buffer to a var
            ;; fzf-lua sometimes breaks this
            buffer (vim.api.nvim_win_get_buf self.win.preview_winid)
            line-count (data-length entry.data)]
        (set self.preview_bufloaded true)
        (vim.api.nvim_buf_set_lines buffer 0 -1 false data) 
        ;; TODO: new syntax type for git status?
        (local filetype :fugitive)
        (vim.api.nvim_buf_set_option buffer :filetype filetype)
        (self.win:update_scrollbar)))
