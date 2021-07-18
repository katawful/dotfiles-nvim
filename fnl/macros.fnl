; packer
(fn Plug [plugin]
    `(use ,plugin))

; convert to string)
(fn sym-tostring [x]
  `,(tostring x))

; get the scope of an option (global, window, or buffer)
(fn get-scope [opt]
  (if (pcall vim.api.nvim_get_option_info opt)
    (. (vim.api.nvim_get_option_info opt) :scope)
    false))

; passed function used to actually set options
(fn set-option [option value scope]
  (match scope
    :global `(vim.api.nvim_set_option ,option ,value)
    :win `(vim.api.nvim_win_set_option 0 ,option ,value)
    :buf `(vim.api.nvim_buf_set_option 0 ,option ,value)))

; set local
(fn setl- [option value]
  (let [option (sym-tostring option)
        value value
        scope :buf]
    (set-option option value scope)))

; set vim options
(fn set- [option value]
  (let [option (sym-tostring option)
        value value
        scope (get-scope option)]
  (set-option option value scope)))

; set append
(fn seta- [option value]
  (let [option  (sym-tostring option)
        value (sym-tostring value)]
    `(tset vim.opt ,option (+ (. vim.opt ,option) ,value))))

; set prepend
(fn setp- [option value]
  (let [option (sym-tostring option)
        value value]
    `(tset vim.opt ,option (^ (. vim.opt ,option) ,value))))

; set remove
(fn setr- [option value]
  (let [option (sym-tostring option)
        value value]
    `(tset vim.opt ,option (- (. vim.opt ,option) ,value))))

; general vim.cmd functions
(fn cmd [string]
  `(vim.cmd ,string))

; set colorscheme
(fn col- [scheme]
  (let [scheme (.. "colorscheme " (sym-tostring scheme))]
  (cmd scheme)))

; autocmd
(var id 0)
(fn au- [event file com]
  (let [group (.. "augroup con_" (sym-tostring id) "\n") ; should be "augroup group\n"
       event (.. "autocmd " (sym-tostring event) " ") ; should be "autocmd Event "
       file (.. file " ") ; should be "filetype "
       com (.. com "\n") ; should be "cmd\n"
       austart "autocmd!\n"
       auend "augroup END"]
    (set id (+ id 1))
    (var output (.. group austart event file com auend))
    (cmd (sym-tostring output))))

; let
(fn let- [scope obj ...]
  (let [scope (sym-tostring scope)
       obj (sym-tostring obj)
       output []
       value []]
    (var output [...])
    (var value [])
    (if (= (length output) 1
      (each [key val (pairs output)]
        (set value  val)))
      (> (length output) 1
        (do (set value output))))
    (match scope
      :g `(tset vim.g ,obj ,value)
      :b `(tset vim.b ,obj ,value)
      :w `(tset vim.w ,obj ,value)
      :t `(tset vim.t ,obj ,value)
      :v `(tset vim.v ,obj ,value)
      :env `(tset vim.env ,obj ,value))))

; nnoremap
(fn nno- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap true)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :n ,left ,right ,tab)))

; inoremap
(fn ino- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap true)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :i ,left ,right ,tab)))

; vnoremap
(fn vno- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap true)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :v ,left ,right ,tab)))

; rnoremap
(fn rno- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap true)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :r ,left ,right ,tab)))

; tnoremap
(fn tno- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap true)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :t ,left ,right ,tab)))

; cnoremap
(fn cno- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap true)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :c ,left ,right ,tab)))

; nmap
(fn nm- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap false)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :n ,left ,right ,tab)))

; vmap
(fn vm- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap false)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :v ,left ,right ,tab)))

; imap
(fn im- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap false)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :i ,left ,right ,tab)))

; rmap
(fn rm- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap false)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :r ,left ,right ,tab)))

; tmap
(fn tm- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap false)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :t ,left ,right ,tab)))

; cmap
(fn cm- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (tset tab :noremap false)
    (each [key val (ipairs [...])]
      (tset tab val true))
    `(vim.api.nvim_set_keymap :c ,left ,right ,tab)))

{
 :ino- ino-
 :im- im-
 :rno- rno-
 :rm- rm-
 :vno- vno-
 :vm- vm-
 :tno- tno-
 :tm- tm-
 :cno- cno-
 :cm- cm-
 :nno- nno-
 :nm- nm-
 :let- let-
 :au- au-
 :set- set-
 :seta- seta-
 :setp- setp-
 :setr- setr-
 :col- col-
 :cmd cmd
 :Plug Plug
}
