; convert to string)
(fn sym-tostring [x]
  `,(tostring x))

; plugin initialization
; for packer.nvim
(fn plugInit [...]
  `(do
     ((. (require :packer) :startup) (fn []
      (do
        ,...)
      ))))

; i find "Plug" to be more semantically ideal
(fn Plug [plugin]
    `(use ,plugin))

; require configs
; lua options really, i find the table lookup syntax to be garbage
(fn opt- [tableOrigin lookupValue ...]
  (let [tableOrigin (sym-tostring tableOrigin)
        lookupValue (sym-tostring lookupValue)
        output [...]]
       `(do
          ((. (require ,tableOrigin) ,lookupValue)
           ,...))))

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

; augroup
(fn aug- [group ...]
  ; set up augroup group autocmd!
  (let [group (.. "augroup " (sym-tostring group) "\nautocmd!")]
    `(do
       (cmd ,group)
       ; do the autocmd
       (do
         ,...)
       ; close the autocmd group
       (cmd "augroup END"))))
; autocmd
(fn auc- [event filetype command]
  (let [event (sym-tostring event)
        filetype (sym-tostring filetype)
        command command]
    ; execute the autocmd
    ; i saw other macros that were much more robust, is this needed?
    ; proper lua support will come eventually anyways so this macro seems EOL
    `(do
      ,(cmd (string.format "autocmd %s %s %s" event filetype command)))))

; let
(fn let- [scope obj ...]
  (let [scope (sym-tostring scope)
       obj (sym-tostring obj)
       output []
       value []]
    (var output [...])
    (var value [])
    ; if number of operands is 1
    (if (= (length output) 1
      (each [key val (pairs output)]
        ; set the output to just the value of the operands
        (set value  val)))
      (> (length output) 1
         ; else set the output to the whole table
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
    (var isBuffer false) ; so we don't have to specify not in a buffer
    ; set that noremap is true
    (tset tab :noremap true)
    ; set each option to be true
    (each [key val (ipairs [...])]
      ; buffer isn't an option for nvim_set_keymap
      ; if we see buffer, set flag
      (match val
        :buffer (do (set isBuffer true))
        ; everything else is a valid option
        & (do (tset tab val true))))
    ; if buffer is set, use a buffer map
    (if (= isBuffer true)
      (do
        `(vim.api.nvim_buf_set_keymap 0 :n ,left ,right ,tab))
      (do
        `(vim.api.nvim_set_keymap :n ,left ,right ,tab)))))

; inoremap
(fn ino- [left right ...]
  (let [left (sym-tostring left)
        right right
        output []
        tab []]
    (var isBuffer false) ; so we don't have to specify not in a buffer
    ; set that noremap is true
    (tset tab :noremap true)
    ; set each option to be true
    (each [key val (ipairs [...])]
      ; buffer isn't an option for nvim_set_keymap
      ; if we see buffer, set flag
      (match val
        :buffer (do (set isBuffer true))
        ; everything else is a valid option
        & (do (tset tab val true))))
    ; if buffer is set, use a buffer map
    (if (= isBuffer true)
      (do
        `(vim.api.nvim_buf_set_keymap 0 :i ,left ,right ,tab))
      (do
        `(vim.api.nvim_set_keymap :i ,left ,right ,tab)))))

; vnoremap
(fn vno- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (var isBuffer false) ; so we don't have to specify not in a buffer
    ; set that noremap is true
    (tset tab :noremap true)
    ; set each option to be true
    (each [key val (ipairs [...])]
      ; buffer isn't an option for nvim_set_keymap
      ; if we see buffer, set flag
      (match val
        :buffer (do (set isBuffer true))
        ; everything else is a valid option
        & (do (tset tab val true))))
    ; if buffer is set, use a buffer map
    (if (= isBuffer true)
      (do
        `(vim.api.nvim_buf_set_keymap 0 :v ,left ,right ,tab))
      (do
        `(vim.api.nvim_set_keymap :v ,left ,right ,tab)))))

; tnoremap
(fn tno- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (var isBuffer false) ; so we don't have to specify not in a buffer
    ; set that noremap is true
    (tset tab :noremap true)
    ; set each option to be true
    (each [key val (ipairs [...])]
      ; buffer isn't an option for nvim_set_keymap
      ; if we see buffer, set flag
      (match val
        :buffer (do (set isBuffer true))
        ; everything else is a valid option
        & (do (tset tab val true))))
    ; if buffer is set, use a buffer map
    (if (= isBuffer true)
      (do
        `(vim.api.nvim_buf_set_keymap 0 :t ,left ,right ,tab))
      (do
        `(vim.api.nvim_set_keymap :t ,left ,right ,tab)))))

; cnoremap
(fn cno- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (var isBuffer false) ; so we don't have to specify not in a buffer
    ; set that noremap is true
    (tset tab :noremap true)
    ; set each option to be true
    (each [key val (ipairs [...])]
      ; buffer isn't an option for nvim_set_keymap
      ; if we see buffer, set flag
      (match val
        :buffer (do (set isBuffer true))
        ; everything else is a valid option
        & (do (tset tab val true))))
    ; if buffer is set, use a buffer map
    (if (= isBuffer true)
      (do
        `(vim.api.nvim_buf_set_keymap 0 :c ,left ,right ,tab))
      (do
        `(vim.api.nvim_set_keymap :c ,left ,right ,tab)))))

; nmap
(fn nm- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (var isBuffer false) ; so we don't have to specify not in a buffer
    ; set that noremap is false
    (tset tab :noremap false)
    ; set each option to be true
    (each [key val (ipairs [...])]
      ; buffer isn't an option for nvim_set_keymap
      ; if we see buffer, set flag
      (match val
        :buffer (do (set isBuffer true))
        ; everything else is a valid option
        & (do (tset tab val true))))
    ; if buffer is set, use a buffer map
    (if (= isBuffer true)
      (do
        `(vim.api.nvim_buf_set_keymap 0 :n ,left ,right ,tab))
      (do
        `(vim.api.nvim_set_keymap :n ,left ,right ,tab)))))

; vmap
(fn vm- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (var isBuffer false) ; so we don't have to specify not in a buffer
    ; set that noremap is false
    (tset tab :noremap false)
    ; set each option to be true
    (each [key val (ipairs [...])]
      ; buffer isn't an option for nvim_set_keymap
      ; if we see buffer, set flag
      (match val
        :buffer (do (set isBuffer true))
        ; everything else is a valid option
        & (do (tset tab val true))))
    ; if buffer is set, use a buffer map
    (if (= isBuffer true)
      (do
        `(vim.api.nvim_buf_set_keymap 0 :v ,left ,right ,tab))
      (do
        `(vim.api.nvim_set_keymap :v ,left ,right ,tab)))))

; imap
(fn im- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (var isBuffer false) ; so we don't have to specify not in a buffer
    ; set that noremap is false
    (tset tab :noremap false)
    ; set each option to be true
    (each [key val (ipairs [...])]
      ; buffer isn't an option for nvim_set_keymap
      ; if we see buffer, set flag
      (match val
        :buffer (do (set isBuffer true))
        ; everything else is a valid option
        & (do (tset tab val true))))
    ; if buffer is set, use a buffer map
    (if (= isBuffer true)
      (do
        `(vim.api.nvim_buf_set_keymap 0 :i ,left ,right ,tab))
      (do
        `(vim.api.nvim_set_keymap :i ,left ,right ,tab)))))

; tmap
(fn tm- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (var isBuffer false) ; so we don't have to specify not in a buffer
    ; set that noremap is false
    (tset tab :noremap false)
    ; set each option to be true
    (each [key val (ipairs [...])]
      ; buffer isn't an option for nvim_set_keymap
      ; if we see buffer, set flag
      (match val
        :buffer (do (set isBuffer true))
        ; everything else is a valid option
        & (do (tset tab val true))))
    ; if buffer is set, use a buffer map
    (if (= isBuffer true)
      (do
        `(vim.api.nvim_buf_set_keymap 0 :t ,left ,right ,tab))
      (do
        `(vim.api.nvim_set_keymap :t ,left ,right ,tab)))))

; cmap
(fn cm- [left right ...]
  (let [left (sym-tostring left)
        right (sym-tostring right)
        output []
        tab []]
    (var isBuffer false) ; so we don't have to specify not in a buffer
    ; set that noremap is false
    (tset tab :noremap false)
    ; set each option to be true
    (each [key val (ipairs [...])]
      ; buffer isn't an option for nvim_set_keymap
      ; if we see buffer, set flag
      (match val
        :buffer (do (set isBuffer true))
        ; everything else is a valid option
        & (do (tset tab val true))))
    ; if buffer is set, use a buffer map
    (if (= isBuffer true)
      (do
        `(vim.api.nvim_buf_set_keymap 0 :c ,left ,right ,tab))
      (do
        `(vim.api.nvim_set_keymap :c ,left ,right ,tab)))))

{
 :ino- ino-
 :im- im-
 :vno- vno-
 :vm- vm-
 :tno- tno-
 :tm- tm-
 :cno- cno-
 :cm- cm-
 :nno- nno-
 :nm- nm-
 :let- let-
 :set- set-
 :setl- setl-
 :seta- seta-
 :setp- setp-
 :setr- setr-
 :col- col-
 :cmd cmd
 :Plug Plug
 :plugInit plugInit
 :aug- aug-
 :auc- auc-
 :opt- opt-
}
