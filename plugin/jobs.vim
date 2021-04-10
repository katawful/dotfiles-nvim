function! LazyGitUpdate()
  Git add -u
  Git commit -m "update"
  Git push
endfunction
