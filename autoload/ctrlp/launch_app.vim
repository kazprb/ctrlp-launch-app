if exists('g:loaded_ctrlp_launch_app') && g:loaded_ctrlp_launch_app
  finish
endif
let g:loaded_ctrlp_launch_app = 1

let s:launch_app_var = {
  \ 'init':   'ctrlp#launch_app#init()',
  \ 'accept': 'ctrlp#launch_app#accept',
  \ 'lname':  'launch-app',
  \ 'sname':  'launch-app',
  \ 'type':   'line',
  \ 'enter':  'ctrlp#launch_app#enter()',
  \ 'exit':   'ctrlp#launch_app#exit()',
  \ 'sort':   0,
  \ }

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:launch_app_var)
else
  let g:ctrlp_ext_vars = [s:launch_app_var]
endif

function! ctrlp#launch_app#init()
  return s:log
endfunc

function! ctrlp#launch_app#accept(mode, str)
  call ctrlp#exit()

  let hash = substitute(a:str, "^.*am", "am", "")
  echo system(hash)

endfunction

" Do something before enterting ctrlp
function! ctrlp#launch_app#enter()

  "let s:log = split(system('termux-contact-list | jq -r ''.[] | to_entries | map("\(.key):\(.value)") | join("\t")'''), "\n")
  
  let s:log = split(system('cat /sdcard/termuxlauncher/.apps-launcher | grep -v printf | grep -v Auth |grep -v launch |grep -v help |grep -v ヘルプ |  grep -e \| -e am | sed -e "N;s/\n//g"'), "\n")

endfunction

" Do something after exiting ctrlp
function! ctrlp#launch_app#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#launch_app#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
