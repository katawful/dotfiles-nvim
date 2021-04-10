function! SwapConceal()
  let s:curr = &conceallevel
  if s:curr ==? 2
    setlocal conceallevel=0
  elseif s:curr ==? 0
    setlocal conceallevel=2
  endif
endfunction
