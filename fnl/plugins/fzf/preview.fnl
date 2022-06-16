(module plugins.fzf.preview)

;;; Generic preview interface
;;; This is not for direct use, but interfacing with other preview modules

(def base (. (require :fzf-lua.previewer.builtin) :base))
(def buffer_or_file (. (require :fzf-lua.previewer.builtin)
                       :buffer_or_file))

(defn get-index* [item] "Get index for current item"
  (tonumber (item:match "^[(%d)]")))

(defn new* [self o opts fzf-win] 
  (set-forcibly! self
                 (setmetatable (base o opts fzf-win)
                               {:__index (vim.tbl_deep_extend :keep self
                                                              base)}))
  self)

(defn parse_entry [self entry-str] "Get content at specified index"
  (let [index (get-index entry-str)]
    (. (contents) index)))

(defn parse-data [data] "Parse data"
  data)

(defn populate_preview_buf [self entry-str] "Populate the preview window"
  (values self entry-str))
