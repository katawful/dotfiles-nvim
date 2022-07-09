(module plugins.file.runners)

;;; Module for handling file specific runners
;;; Things like: jump to test, jump to compile, reverse jump, etc...

;; String -- jump leader subkey
(defonce leader-jump :<leader>j)

;; define leader keys for test jumping
;; fnlfmt: skip
(def test-edit (.. leader-jump "tt"))
(def test-split (.. leader-jump :ts))
(def test-vsplit (.. leader-jump :tv))

;; define leader keys for compiled file jumping
;; fnlfmt: skip
(def compile-edit (.. leader-jump "cc"))
(def compile-split (.. leader-jump :cs))
(def compile-vsplit (.. leader-jump :cv))

;; FN -- open things based on each split type
;; Might be useful to add tab support
(defn vsplit [file] "Open new window in a vertical split and edit it"
      (vim.cmd (.. "vsplit " file)))

(defn split [file] "Open new window in a horizontal split and edit it"
      (vim.cmd (.. "split " file)))

(defn edit [file] "Edit in window" (vim.cmd (.. "edit " file)))

;; FN -- Root finder function
;; Put here in case I switch it
(defn ->root [] "Go to root directory if possible" (vim.cmd :Rooter))

;; FN -- jump to a test
;; @split-type -- how to split the file
;; @test-ext -- extension desired for the test
(defn ->test [split-type test-ext]
      "Jump to a test from a desired file
It notifies the user if a test is empty, but still goes to the empty file anyways"
      (->root) ; creating a test assumes I'm in a project anyways
      (let [dir-root (let [dir (vim.fn.expand "%:h")]
                       (if (= dir ".") "" (.. dir "/")))
            file-name (vim.fn.expand "%:t:r")
            current-dir (vim.fn.getcwd)
            test-file (.. current-dir :/test/ dir-root file-name test-ext)
            truncated-test-file (.. :/test/ dir-root file-name test-ext)]
        ;; I want to know if I'm making a new test
        ;; Good thing to add skeleton/template support here if needed
        (if (= (vim.fn.filewritable test-file) 0)
            (vim.notify (.. "No test found for '" file-name
                            "',creating a new test in:"
                            truncated-test-file)))
        (match split-type
          :vsplit (vsplit test-file)
          :split (split test-file)
          :edit (edit test-file))))

;; FN -- jump to the compiled file if it exists based on split type
;; @split-type -- how we want to open the file
;; @ext -- file extension for compiled file
;; @compile-dir -- directory for compiled file
;; -- compile-dir is for when a dir is specified
;; -- if nil, then assumed that compiled file is in same dir
(defn ->compiled [split-type ext compile-dir]
      "Jump to the compiled file based on directory path.
If path is nil, it is assumed that the compiled file should be in the same dir as the source.
If no file was found, simply warn the user as it is unneeded to go to an empty file."
      (->root) ; jumping to a compiled file assumes I'm in a project
      (let [dir-root (let [dir (vim.fn.expand "%:h")]
                       (if (= dir ".") ""
                           (-> dir
                               (string.gsub ".-/(.*)" "%1")
                               (.. "/"))))
            file-name (vim.fn.expand "%:t:r")
            full-file-name (vim.fn.expand "%:t")
            current-dir (vim.fn.getcwd)
            compiled-file (if compile-dir
                              (string.format "%s/%s/%s%s.%s" current-dir
                                             compile-dir dir-root file-name ext)
                              (string.format "%s/%s%s.%s" current-dir dir-root
                                             file-name ext))
            compiled-dir (if compile-dir
                             (string.format "%s/%s" current-dir compile-dir)
                             (string.format "%s" current-dir))]
        ;; I want to know if no compiled file exists and only jump if it does
        ;; Good thing to add skeleton/template support here if needed
        (if (= (vim.fn.filewritable compiled-file) 0)
            (vim.notify (.. "No compiled file found for '" full-file-name 
                            "' in:"
                            compiled-dir)
                        vim.log.levels.WARN)
            (match split-type
              :vsplit (vsplit compiled-file)
              :split (split compiled-file)
              :edit (edit compiled-file)))))
