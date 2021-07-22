(module bufferline
        {require-macros [macros]})

(opt- bufferline setup
 { :options {
             :numbers :both
             :number_style :subscript
             :separator_style :slant
             :mappings true}})
   ; :highlights {
   ;              :fill {
   ;                     :guifg { :attribute :bg
   ;                              :highlight :Normal}
   ;                     :guibg { :attribute :fg
   ;                              :highlight :Constant}}
   ;              :tab {
   ;                     :guifg { :attribute :fg
   ;                              :highlight :Normal}
   ;                     :guibg { :attribute :fg
   ;                              :highlight :Special}}
   ;              :tab_selected {
   ;                     :guifg { :attribute :fg
   ;                              :highlight :Normal}
   ;                     :guibg { :attribute :fg
   ;                              :highlight :Include}}
   ;              :tab_close {
   ;                     :guifg { :attribute :fg
   ;                              :highlight :Normal}
   ;                     :guibg { :attribute :fg
   ;                              :highlight :Include}}
   ;              :buffer_visible {
   ;                     :guifg { :attribute :fg
   ;                              :highlight :Normal}
   ;                     :guibg { :attribute :fg
   ;                              :highlight :Define}}
   ;              :buffer_selected {
   ;                     :guifg { :attribute :fg
   ;                              :highlight :Normal}
   ;                     :guibg { :attribute :fg
   ;                              :highlight :SpecialChar}
   ;                     :gui "bold,italic"}
   ;              :background {
   ;                     :guifg { :attribute :fg
   ;                              :highlight :Normal}
   ;                     :guibg { :attribute :fg
   ;                              :highlight :Delimiter}}}})
