(module plugins.fzf.session.preview
        {autoload {preview plugins.fzf.preview
                   configs plugins.fzf.configs
                   store plugins.session.store
                   json plugins.session.json
                   s aniseed.string}})

;;; Previewer for sessions

(def base (. (require :fzf-lua.previewer.builtin) :base))
(def buffer_or_file (. (require :fzf-lua.previewer.builtin) :buffer_or_file))

(def contents-type {})

;; output the module table explicitly
;; This is needed to get the preview window working
(def module-tab *module*)

(defn get-index [item] "Get index for current item" (preview.get-index* item))

(defn new [self o opts fzf-win] (preview.new* self o opts fzf-win))

(defn contents [] "Get the sessions"
      (let [output []]
        (each [_ session (pairs (-> (json.<-file)
                                    (json.decode)))]
          (table.insert output
                        {:text session.name
                         :name session.name
                         :last session.last
                         :dir session.dir}))
        output))

(defn parse_entry [self entry-str] "Get content at specified index"
      (let [index (get-index entry-str)]
        (. (contents) index)))

(defn parse-data [data] "Get rid of newlines so it can be output"
      (s.split data "\n"))

(defn data-length [data] "Find the length of the data"
      (local (_ output) (string.gsub data "\n" "")) output)

(defn populate_preview_buf [self entry-str]
      "Populate preview window with session information"
      (let [entry (self:parse_entry entry-str)
            data (parse-data entry.last) ; line-count (data-length entry.last)]
            line-count 1]
        (set self.preview_bufloaded true)
        (vim.api.nvim_buf_set_lines self.preview_bufnr 0 line-count false data)
        (self.win:update_scrollbar)))
