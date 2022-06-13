function! FloatWin(called_command)
  " get the size of the current window
  let l:curr_win = win_getid('%')
  let l:curr_height = nvim_win_get_height(l:curr_win)
  let l:curr_width = nvim_win_get_width(l:curr_win)
  " get the size of the command supplied
  let l:width = 70
  let l:height = 20
  " set window position to center of window
  let l:col = (l:curr_width / 2 - l:width / 2)
  let l:row = (l:curr_height / 2 - l:height / 2)
  let l:opts = {
        \'relative': 'win',
        \'win': l:curr_win,
        \'width': l:width+2,
        \'height': l:height,
        \'col': l:col,
        \'row': l:row,
        \'style': 'minimal'
        \}
  " create the buffer and open the window
  let s:buf = nvim_create_buf(v:false, v:true)
  let s:win = nvim_open_win(s:buf, 1, l:opts)
  execute a:called_command
endfunction

function! FloatWinClose()
  call nvim_win_close(s:win, 0)
endfunction
