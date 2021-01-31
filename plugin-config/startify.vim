let g:startify_lists = [
  \ { 'type': 'files',     'header': ['   Recent Global Files']            },
  \ { 'type': 'dir',       'header': ['   Recent Files in: '. getcwd()] },
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \ ]
let g:startify_files_number = 5
let g:startify_bookmarks = [ 
  \ { 'i': '~/init.vim' }, 
  \ { 'z': '~/.zshrc'},
  \ { 'c': '~/.config/i3/config' },
  \ { 's': '~/.config/sway/config' },
  \ ]
let g:startify_commands = [
  \ { 'v': 'VimwikiIndex' },
  \ { 'd': 'VimwikiDiaryIndex' },
  \ ]
let g:startify_fortune_use_unicode = 1
let g:startify_padding_left = 8
