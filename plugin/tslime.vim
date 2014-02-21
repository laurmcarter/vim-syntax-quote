fu! FixNewlines(text)
    let text = a:text
    let text = substitute(text , "\n" , "\x0d" , 'g')
    return text
endf

function! Copy_to_Tmux(text)
  let text = FixNewlines(a:text)
  call system("tmux set-buffer '" . substitute(text, "'", "'\\\\''", 'g') . "'" )
endfunction

function! Tmux_Session_Names(A,L,P)
  return system("tmux list-sessions -F '#{session_name}'")
endfunction

function! Tmux_Window_Names(A,L,P)
  return system("tmux list-windows -t" . b:tmux_sessionname . "-F #{window_name}")
endfunction

function! Tmux_Pane_Numbers(A,L,P)
  return system("tmux list-panes -t " . b:tmux_sessionname . ":" . b:tmux_windowname . " -F #{pane_index}")
endfunction

function! Set_Tmux_Vars()
  let b:tmux_sessionname = input("session name: ", "", "custom,Tmux_Session_Names")
  let b:tmux_windowname = substitute(input("window name: ", "", "custom,Tmux_Window_Names"), ":.*$" , '', 'g')

  if system("tmux list-panes -t " . b:tmux_sessionname . ":" . b:tmux_windowname . " | wc -l") > 1
    let b:tmux_panenumber = input("pane number: ", "", "custom,Tmux_Pane_Numbers")
  end

  if !exists("g:tmux_sessionname") || !exists("g:tmux_windowname")
    let g:tmux_sessionname = b:tmux_sessionname
    let g:tmux_windowname = b:tmux_windowname
    if exists("b:tmux_panenumber")
      let g:tmux_panenumber = b:tmux_panenumber
    end
  end
endfunction

fu! Trim(text)
    let text = a:text
    let text = FixNewlines(text)
    let text = substitute(text , "^[\s\r]*" , ""   , 'g')
    let text = substitute(text , "[\s\r]*$" , ""   , 'g')
    return text
endf

function! This_Tmux()
  let b:tmux_sessionname = Trim(system("tmux display-message -p '#S'"))
  let b:tmux_windowname = Trim(system("tmux display-message -p '#I'"))
  let b:tmux_panenumber = Trim(system("tmux display-message -p '#P'"))

  if !exists("g:tmux_sessionname") || !exists("g:tmux_windowname")
    let g:tmux_sessionname = b:tmux_sessionname
    let g:tmux_windowname = b:tmux_windowname
    if exists("b:tmux_panenumber")
      let g:tmux_panenumber = b:tmux_panenumber
    end
  end
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

vnoremap <C-c><C-c> "ry :call Copy_to_Tmux(@r)<CR>
nmap <C-c><C-c> vap<C-c><C-c>

nnoremap <C-c>v :call Set_Tmux_Vars()<CR>
