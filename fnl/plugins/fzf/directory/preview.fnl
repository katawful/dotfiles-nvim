(module plugins.fzf.directory.preview
  {autoload {preview plugins.fzf.preview
             configs plugins.fzf.configs
             s aniseed.string}})

;;; Previewer for directories

(def base (. (require :fzf-lua.previewer.builtin) :base))
(def buffer_or_file (. (require :fzf-lua.previewer.builtin) :buffer_or_file))

(def contents-type {})

;; output the module table explicitly
;; This is needed to get the preview window working
(def module-tab *module*)

(defn get-index [item] "Get index for current item" (preview.get-index* item))

(defn new [self o opts fzf-win] (preview.new* self o opts fzf-win))

(defn contents []
  "Show working directories"
  (let [output []]
    (if contents-type.current-dir
      (let [fd (vim.loop.fs_opendir "." nil 500)
            cwd (vim.loop.cwd)]
        (each [_ file (pairs (vim.loop.fs_readdir fd))]
          (when (= file.type :directory)
            (table.insert output {:text file.name
                                  :data "data\n"
                                  :desc :desc
                                  :dir (.. cwd "/" file.name)})))
        (vim.loop.fs_closedir fd)))
    output))

(defn parse_entry [self entry-str] "Get content at specified index"
      (let [index (get-index entry-str)]
        (. (contents) index)))

(defn parse-data [data] "Get rid of newlines so it can be output"
      (s.split data "\n"))

(defn data-length [data] "Find the length of the data"
      (local (_ output) (string.gsub data "\n" "")) output)

(defn populate_preview_buf [self entry-str] "Populate the preview window with dirbuf"
      (let [entry (self:parse_entry entry-str)]
        (vim.api.nvim_buf_call self.preview_bufnr (fn [] ((. (require :dirbuf) :open) entry.dir)))
        (self.win:update_scrollbar)))
