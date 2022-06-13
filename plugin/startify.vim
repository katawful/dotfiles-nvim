function! ShowCurrRepo()
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
