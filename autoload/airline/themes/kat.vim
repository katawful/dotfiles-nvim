" kat Airline
let g:airline#themes#kat#palette = {}

" Normal mode
let s:N  = [ '', '', 15, 8 ]
let s:N2 = [ '', '', 0, 5 ]
let s:N3 = [ '', '', 0, 4 ]

" Insert mode
let s:I  = [ '', '', 0, 5 ]
let s:I2 = [ '', '', 8, 6 ]
let s:I3 = [ '', '', 8, 14 ]

" Visual mode
let s:V  = [ '', '', 0, 1 ]
let s:V2 = [ '', '', 15, 8 ]
let s:V3 = [ '', '', 0, 9 ]

" Replace mode
let s:R  = [ '', '', 0, 4 ]
let s:R2 = [ '', '', 0, 3 ]
let s:R3 = [ '', '', 0, 6 ]

let g:airline#themes#kat#palette.normal  = airline#themes#generate_color_map(s:N, s:N2, s:N3)
let g:airline#themes#kat#palette.insert  = airline#themes#generate_color_map(s:I, s:I2, s:I3)
let g:airline#themes#kat#palette.visual  = airline#themes#generate_color_map(s:V, s:V2, s:V3)
let g:airline#themes#kat#palette.replace = airline#themes#generate_color_map(s:R, s:R2, s:R3)

let g:airline#themes#kat#palette.accents = { 'blue': [ '', '', 0, 6 ] }

" Inactive mode
let s:IN1 = [ '', '', 1, 8 ]
let s:IN2 = [ '', '', 0, 6 ]

let s:IA = [ s:IN1[1], s:IN2[1], s:IN1[3], s:IN2[3], '' ]
let g:airline#themes#kat#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)

" Warnings
let s:WI = [ '', '', 0, 1, 'BOLD' ]
let g:airline#themes#kat#palette.normal.airline_warning  = s:WI
let g:airline#themes#kat#palette.insert.airline_warning  = s:WI
let g:airline#themes#kat#palette.visual.airline_warning  = s:WI
let g:airline#themes#kat#palette.replace.airline_warning = s:WI

let g:airline#themes#kat#palette.normal.airline_error  = s:WI
let g:airline#themes#kat#palette.insert.airline_error  = s:WI
let g:airline#themes#kat#palette.visual.airline_error  = s:WI
let g:airline#themes#kat#palette.replace.airline_error = s:WI

" Tabline
let g:airline#themes#kat#palette.tabline = {
      \ 'airline_tab':     [ '', '', 15, 0 ],
      \ 'airline_tabsel':  [ '', '', 0, 5 ],
      \ 'airline_tabtype': [ '', '', 0, 4 ],
      \ 'airline_tabfill': [ '', '', 15, 0 ],
      \ 'airline_tabmod':  [ '', '', 0, 4 ]
\ }

if !get(g:, 'loaded_ctrlp', 0)
  finish
endif

let g:airline#themes#kat#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '', '', 0, 0 ],
      \ [ '', '', 0, 0 ],
      \ [ '', '', 0, 0 ] )
