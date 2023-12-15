" Vim syntax file
" Language: Oblivion Schema XML
" XML Maintainer: Christian Brabandt <cb@256bit.org>
" Oblivion Schema XML Maintainer: Kat <katisntgood@gmail.com>
" Repository: https://github.com/chrisbra/vim-xml-ftplugin
" Previous Maintainer: Johannes Zellner <johannes@zellner.org>
" Author: Paul Siegmann <pauls@euronet.nl>
" Last Changed:	Nov 03, 2019
" Filenames:	*.xml
" Last Change:
" 20190923 - Fix xmlEndTag to match oblXmlTag (vim/vim#884)
" 20190924 - Fix xmlAttribute property (amadeus/vim-xml@d8ce1c946)
" 20191103 - Enable spell checking globally
" 20210428 - Improve syntax synchronizing

" NOTES FOR OBLIVION SCHEMA XML:
" This syntax file is directly copied from the maintree XML syntax file.
" This is purely meant to improve coloring specifically for Oblivion's XML
" Schema. The filetype, thus, must be set to "oblxml" to use this.

" CONFIGURATION:
"   syntax folding can be turned on by
"
"      let g:xml_syntax_folding = 1
"
"   before the syntax file gets loaded (e.g. in ~/.vimrc).
"   This might slow down syntax highlighting significantly,
"   especially for large files.
"
" CREDITS:
"   The original version was derived by Paul Siegmann from
"   Claudio Fleiner's html.vim.
"
" REFERENCES:
"   [1] http://www.w3.org/TR/2000/REC-xml-20001006
"   [2] http://www.w3.org/XML/1998/06/xmlspec-report-19980910.htm
"
"   as <hirauchi@kiwi.ne.jp> pointed out according to reference [1]
"
"   2.3 Common Syntactic Constructs
"   [4]    NameChar    ::=    Letter | Digit | '.' | '-' | '_' | ':' | CombiningChar | Extender
"   [5]    Name        ::=    (Letter | '_' | ':') (NameChar)*
"
" NOTE:
"   1) empty tag delimiters "/>" inside attribute values (strings)
"      confuse syntax highlighting.
"   2) for large files, folding can be pretty slow, especially when
"      loading a file the first time and viewoptions contains 'folds'
"      so that folds of previous sessions are applied.
"      Don't use 'foldmethod=syntax' in this case.

" WARNING:
" This syntax file will used Neovim highlight groups. This is not compatible
" with Vim as a result (@group)

if has("vim")
    finish
endif

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

let s:xml_cpo_save = &cpo
set cpo&vim

syn case match

" Allow spell checking in tag values,
" there is no syntax region for that,
" so enable spell checking in top-level elements
" <tag>This text is spell checked</tag>
syn spell toplevel

" mark illegal characters
syn match oblXmlError "[<&]"

" strings (inside tags) aka VALUES
"
" EXAMPLE:
"
" <tag foo.attribute = "value">
"                      ^^^^^^^
" NOTE: Oblivion schema doesn't use strings as strings, so I renamed this to
" just Value
syn region  oblXmlValue
      \ contained
      \ contains=oblXmlSelector,oblXmlSelectedTrait
      \ display
      \ start=+"+ end=+"+

syn keyword oblXmlSelectedTrait
      \ contained
      \ display
      \ alpha
      \ animation
      \ blue
      \ child_count childcount
      \ class
      \ clickcountafter clickcountbefore
      \ clicked
      \ clicksound
      \ clips
      \ clipwindow
      \ cropx cropy cropoffsetx cropoffsety
      \ depth
      \ depth3d
      \ disablefade
      \ explorefade
      \ fileheight
      \ filename
      \ filewidth
      \ focus
      \ focusinset
      \ focussize
      \ font
      \ green
      \ height
      \ id
      \ isHTML
      \ justify
      \ listclip
      \ listindex
      \ locus
      \ menufade
      \ mouseover
      \ pagecount
      \ pagenum
      \ red
      \ repeathorizontal
      \ repeatvertical
      \ shiftclicked
      \ stackingtype
      \ string
      \ target
      \ tile
      \ user0 user1 user2 user3 user4 user5 user6 user7 user8 user9 user10 user11
      \ user12 user13 user14 user15 user16 user17 user18 user19 user20
      \ visible
      \ width
      \ wraplimit wraplines
      \ wrapwidth
      \ x y
      \ xbuttona xbuttonb xbuttony xbuttonx xbuttonlt xbuttonlb xbuttonrt xbuttonrb
      \ xdefault
      \ xlist
      \ xscroll
      \ xup xdown xleft xright
      \ zoom


syn keyword oblXmlSelector
      \ contained
      \ nextgroup=oblXmlSelectorStart
      \ display
      \ me
      \ child
      \ last
      \ parent
      \ sibling
      \ screen
      \ strings

syn match oblXmlSelectorStart
      \ contained
      \ nextgroup=oblXmlSelectorArgument
      \ display
      \ +(+

syn match oblXmlSelectorArgument
      \ contained
      \ display
      \ nextgroup=oblXmlSelectorEnd
      \ +[a-zA-Z0-9_]*+

syn match oblXmlSelectorEnd
      \ contained
      \ display
      \ +)+

syn keyword oblXmlSelectorPunct contained ( )

syn match oblXmlNumber
      \ containedin=oblXmlRegion
      \ display
      \ +[0-9.-]\++

syn match oblXmlString contained 
      \ containedin=oblXmlRegion
      \ skipwhite
      \ +[a-zA-Z\\/*%$#@!(){}\[\],`~.][a-zA-Z\\/*%$#@!(){}\[\],`~0-9_.]*+


" punctuation (within attributes) e.g. <tag xml:foo.attribute ...>
"                                              ^   ^
" syn match   oblXmlAttribPunct +[-:._]+ contained display
syn keyword oblXmlAttrib
      \ contained
      \ display
      \ src
      \ name
      \ trait
syn match   oblXmlAttribPunct +[:.]+ contained display

" no highlighting for oblXmlEqual (oblXmlEqual has no highlighting group)
syn match   oblXmlEqual +=+ display

syn keyword oblXmlTagNameTile
      \ contained
      \ display
      \ 3d
      \ image
      \ menu
      \ nif
      \ rect
      \ template
      \ text

syn keyword oblXmlTagNameTrait
      \ contained
      \ display
      \ alpha
      \ animation
      \ blue
      \ child_count childcount
      \ class
      \ clickcountafter clickcountbefore
      \ clicked
      \ clicksound
      \ clips
      \ clipwindow
      \ cropx cropy cropoffsetx cropoffsety
      \ depth
      \ depth3d
      \ disablefade
      \ explorefade
      \ fileheight
      \ filename
      \ filewidth
      \ focus
      \ focusinset
      \ focussize
      \ font
      \ green
      \ height
      \ id
      \ isHTML
      \ justify
      \ listclip
      \ listindex
      \ locus
      \ menufade
      \ mouseover
      \ pagecount
      \ pagenum
      \ red
      \ repeathorizontal
      \ repeatvertical
      \ shiftclicked
      \ stackingtype
      \ string
      \ target
      \ tile
      \ user0 user1 user2 user3 user4 user5 user6 user7 user8 user9 user10 user11
      \ user12 user13 user14 user15 user16 user17 user18 user19 user20
      \ visible
      \ width
      \ wraplimit wraplines
      \ wrapwidth
      \ x y
      \ xbuttona xbuttonb xbuttony xbuttonx xbuttonlt xbuttonlb xbuttonrt xbuttonrb
      \ xdefault
      \ xlist
      \ xscroll
      \ xup xdown xleft xright
      \ zoom

syn keyword oblXmlTagNameInclude
      \ contained
      \ display
      \ include
      \ copy

syn keyword oblXmlTagNameOperator
      \ contained
      \ display
      \ abs
      \ add
      \ and
      \ ceil
      \ div
      \ eq
      \ floor
      \ trunc
      \ gt
      \ gte
      \ log
      \ ln
      \ lt
      \ lte
      \ max
      \ min
      \ mod
      \ mul
      \ mult
      \ neq
      \ not
      \ onlyif
      \ onlyifnot
      \ or
      \ rand
      \ ref
      \ sub

syn match oblXmlTagNameCustom
      \ contained
      \ display
      \ +_[a-zA-Z_]\++

" no syntax folding:
" - contained attribute removed
" - oblXmlRegion not defined
"
syn region   oblXmlTag
      \ matchgroup=oblXmlTag start=+<[^ /!?<>"']\@=+
      \ matchgroup=oblXmlTag end=+>+
      \ contains=oblXmlError,oblXmlAttrib,oblXmlEqual,oblXmlValue,@oblXmlStartTagHook,oblXmlTagNameTile,oblXmlTagNameTrait,oblXmlTagNameOperator,oblXmlTagNameCustom,oblXmlTagNameInclude

syn region   oblXmlEndTag
      \ matchgroup=oblXmlTag start=+</[^ /!?<>"']\@=+
      \ matchgroup=oblXmlTag end=+>+
      \ conceal
      \ cchar=
      \ contains=oblXmlNamespace,oblXmlAttribPunct,@oblXmlTagHook,oblXmlTagNameTile,oblXmlTagNameTrait,oblXmlTagNameOperator,oblXmlTagNameCustom,oblXmlTagNameInclude


" &entities; compare with dtd
syn match   oblXmlEntity                 "&[^; \t]*;" contains=oblXmlEntityPunct
syn match   oblXmlEntityPunct  contained "[&.;]"

" no syntax folding:
" - fold attribute removed
"
syn region  oblXmlComment
      \ start=+<!+
      \ end=+>+
      \ contains=oblXmlCommentStart,oblXmlCommentError
      \ extend

syn match oblXmlCommentStart   contained "<!" nextgroup=oblXmlCommentPart
syn keyword oblXmlTodo         contained TODO FIXME XXX
syn keyword oblXmlNote         contained NOTE INFO
syn keyword oblXmlWarn         contained WARN
syn keyword oblXmlError        contained ERROR DANGER
syn match oblXmlCommentContent contained containedin=oblXmlCommentPart
      \ "[ a-zA-Z0-9*/-_\t"'`~,.\\\[\]{}<>!@#$%^&()]"
syn match   oblXmlCommentError contained "[^><!]"
syn region  oblXmlCommentPart
      \ start=+--+
      \ end=+--+
      \ contained
      \ contains=oblXmlTodo,oblXmlNote,oblXmlWarn,oblXmlError,@oblXmlCommentHook,@Spell,oblXmlCommentContent

syn region oblXmlRegion
      \ start=+<\z([^ /!?<>"']\+\)+
      \ skip=+<!--\_.\{-}-->+
      \ end=+</\z1\_\s\{-}>+
      \ end=+/>+
      \ fold
      \ contains=oblXmlTag,oblXmlEndTag,oblXmlRegion,oblXmlComment,oblXmlEntity,oblXmlProcessing,@oblXmlRegionHook,@Spell,oblXmlNumber,oblXmlString
      \ keepend
      \ extend


" Processing instructions
" This allows "?>" inside strings -- good idea?
syn region  oblXmlProcessing matchgroup=oblXmlProcessingDelim start="<?" end="?>" contains=oblXmlAttrib,oblXmlEqual,oblXmlValue


" synchronizing

syn sync match oblXmlSyncComment grouphere oblXmlComment +<!--+
syn sync match oblXmlSyncComment groupthere NONE +-->+

" The following is slow on large documents (and the doctype is optional
" syn sync match oblXmlSyncDT grouphere  oblXmlDocType +\_.\(<!DOCTYPE\)\@=+
" syn sync match oblXmlSyncDT groupthere  NONE       +]>+

if exists('g:xml_syntax_folding')
    syn sync match oblXmlSync grouphere   oblXmlRegion  +\_.\(<[^ /!?<>"']\+\)\@=+
    " syn sync match oblXmlSync grouphere  oblXmlRegion "<[^ /!?<>"']*>"
    syn sync match oblXmlSync groupthere  oblXmlRegion  +</[^ /!?<>"']\+>+
endif

syn sync minlines=100 maxlines=200


" The default highlighting.
hi def link oblXmlTodo		@text.todo
hi def link oblXmlNote		@text.note
hi def link oblXmlWarn		@text.warning
hi def link oblXmlError		@error
hi def link oblXmlTag		@tag
hi def link oblXmlTagName	@tag
hi def link oblXmlTagNameTile  @function.builtin
hi def link oblXmlTagNameInclude  @include
hi def link oblXmlTagNameCustom  @function
hi def link oblXmlTagNameTrait  @field
hi def link oblXmlTagNameOperator  @operator
hi def link oblXmlEndTag		Identifier
hi def link oblXmlEntity		@define
hi def link oblXmlEntityPunct	@punctuation
hi def link oblXmlNumber	@number
hi def link oblXmlSelector  @method
hi def link oblXmlSelectorArgument  @parameter
hi def link oblXmlSelectedTrait  @parameter
hi def link oblXmlSelectorStart  @punctuation.delimiter
hi def link oblXmlSelectorEnd  @punctuation.delimiter

hi def link oblXmlAttribPunct	Comment
hi def link oblXmlAttrib	@attribute

hi def link oblXmlValue		@string.special
hi def link oblXmlString		@string
hi def link oblXmlComment		Comment
hi def link oblXmlCommentStart	oblXmlComment
hi def link oblXmlCommentPart	Comment
hi def link oblXmlCommentError	Error
hi def link oblXmlCommentContent	@text.literal
hi def link oblXmlError		Error

hi def link oblXmlProcessingDelim	Comment
hi def link oblXmlProcessing	Type

hi def link oblXmlDocTypeDecl	Function
hi def link oblXmlDocTypeKeyword	Statement
hi def link oblXmlInlineDTD	Function

let b:current_syntax = "xml"

let &cpo = s:xml_cpo_save
unlet s:xml_cpo_save

" vim: ts=4
