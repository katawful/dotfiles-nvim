function! s:show_curr_repo()
  silent! !git rev-parse --is-inside-work-tree
  if v:shell_error == 0
    let git = 'git'
    let commits = systemlist(git .' log --oneline | head -n5')
    let git = 'G' . git[1:]
    return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
  else
    return 0
  endif
endfunction

let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   Recent Global Files']},
      \ { 'type': 'dir',       'header': ['   Recent Files in: '. getcwd()]},
      \ { 'type': function('s:show_curr_repo'), 'header': ['   Commits in '. getcwd()]},
      \ { 'type': 'sessions',  'header': ['   Sessions']},
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']},
      \ { 'type': 'commands',  'header': ['   Commands']},
      \ ]
let g:startify_files_number = 5
let g:startify_bookmarks = [
      \ { 'i': '~/init.vim' },
      \ { 'z': '~/.zshrc'},
      \ { 'c': '~/.config/i3/config' },
      \ { 's': '~/.config/sway/config' },
      \ ]
let g:startify_commands = [
      \ { 'l': 'cd ~/Documents/My Notes/C++Primer' },
      \ { 'o': 'cd ~/Documents/Programming/oblivion-git' },
      \ { '+': 'cd ~/Documents/Programming/Exercises/C++/C++ Primer Exerices' },
      \ { 'S': 'cd ~/Documents/Programming/katawful.github.io' },
      \ { 'v': 'VimwikiIndex' },
      \ { 'd': 'VimwikiDiaryIndex' },
      \ ]
let g:startify_fortune_use_unicode = 1
let g:startify_padding_left = 8
