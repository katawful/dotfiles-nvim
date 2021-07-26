(module bufferline
        {require-macros [macros]})

(opt- bufferline setup
 { :options {
             :numbers :both
             :number_style :subscript
             :separator_style :slant
             :mappings true
             :indicator_icon "▎"
             :buffer_close_icon ""
             :modified_icon ""
             :close_icon ""
             :left_trunc_marker ""
             :right_trunc_marker ""}

  :highlights {
               :fill {
                      :guifg { :attribute :bg
                              :highlight :Normal}
                      :guibg { :attribute :fg
                              :highlight :Conditional}}

               :tab {
                     :guifg { :attribute :bg
                             :highlight :Normal}
                     :guibg { :attribute :fg
                             :highlight :Exception}}
               :tab_selected {
                              :guifg { :attribute :bg
                                      :highlight :Normal}
                              :guibg { :attribute :fg
                                      :highlight :SpecialChar}}
               :tab_close {
                           :guifg { :attribute :bg
                                   :highlight :Normal}
                           :guibg { :attribute :fg
                                   :highlight :Define}}

               :info {
                      :guifg { :attribute :bg
                              :highlight :Normal}
                      :guibg { :attribute :bg
                              :highlight :SpecialComment}}

               :buffer_visible {
                                :guifg { :attribute :bg
                                        :highlight :Normal}
                                :guibg { :attribute :fg
                                        :highlight :SpecialComment}}
               :buffer_selected {
                                 :guifg { :attribute :bg
                                         :highlight :Normal}
                                 :guibg { :attribute :fg
                                         :highlight :SpecialChar}
                                 :gui "bold,italic"}

               :close_button {
                                :guifg { :attribute :bg
                                        :highlight :Normal}
                                :guibg { :attribute :fg
                                        :highlight :Exception}
                                :gui "bold"}
               :close_button_visible {
                                :guifg { :attribute :bg
                                        :highlight :Normal}
                                :guibg { :attribute :fg
                                        :highlight :SpecialComment}
                                :gui "bold"}
               :close_button_selected {
                                :guifg { :attribute :bg
                                        :highlight :Normal}
                                :guibg { :attribute :fg
                                        :highlight :SpecialChar}
                                :gui :bold}

               :modified {
                          :guifg { :attribute :fg
                                  :highlight :Tag}
                          :guibg { :attribute :fg
                                  :highlight :Exception}
                          }
               :modified_visible {
                                  :guifg { :attribute :fg
                                          :highlight :Tag}
                                  :guibg { :attribute :fg
                                          :highlight :SpecialComment}
                                  }
               :modified_selected {
                                   :guifg { :attribute :fg
                                           :highlight :Tag}
                                   :guibg { :attribute :fg
                                           :highlight :SpecialChar}
                                   }

               :duplicate_selected {
                                    :guifg { :attribute :fg
                                            :highlight :Normal}
                                    :guibg { :attribute :fg
                                            :highlight :SpecialChar}
                                    }
               :duplicate_visible {
                                   :guifg { :attribute :bg
                                           :highlight :Normal}
                                   :guibg { :attribute :fg
                                           :highlight :SpecialComment}
                                   }
               :duplicate {
                           :guifg { :attribute :bg
                                   :highlight :Normal}
                           :guibg { :attribute :fg
                                   :highlight :Exception}
                           }

               :separator_selected {
                                    :guifg { :attribute :fg
                                            :highlight :Conditional}
                                    :guibg { :attribute :fg
                                            :highlight :SpecialChar}
                                    }
               :separator_visible {
                                   :guifg { :attribute :fg
                                           :highlight :Conditional}
                                   :guibg { :attribute :fg
                                           :highlight :SpecialComment}
                                   }
               :separator {
                           :guifg { :attribute :fg
                                   :highlight :Conditional}
                           :guibg { :attribute :fg
                                   :highlight :Exception}
                           }

               :indicator_selected {
                                    :guifg { :attribute :bg
                                            :highlight :Normal}
                                    :guibg { :attribute :fg
                                            :highlight :SpecialChar}
                                    }

               :pick_selected {
                               :guifg { :attribute :fg
                                       :highlight :Normal}
                               :guibg { :attribute :fg
                                       :highlight :SpecialChar}
                               }
               :pick_visible {
                              :guifg { :attribute :fg
                                      :highlight :Normal}
                              :guibg { :attribute :fg
                                      :highlight :SpecialChar}
                              }
               :pick {
                      :guifg { :attribute :fg
                               :highlight :Normal}
                      :guibg { :attribute :fg
                               :highlight :SpecialChar}
                       }

               :background {
                             :guifg { :attribute :bg
                                     :highlight :Normal}
                             :guibg { :attribute :fg
                                     :highlight :Exception}}}})
