let g:boilerplate_ultisnips_skel_trigger = '_skel'

" attempt to insert the mapping `skell`, reverting if unsuccesful
function! s:try_insert(skel)
  execute "normal! i" . a:skel . "\<C-r>=UltiSnips#ExpandSnippet()\<CR>"

  if g:ulti_expand_res == 0
    silent! undo
  endif

  return g:ulti_expand_res
endfunction

" unconditionally insert the skeleton
function! boilerplate_ultisnips#InsertSkeleton() abort
  call s:try_insert(g:boilerplate_ultisnips_skel_trigger)
endfunction

" insert the skeleton IFF the buffer is empty
function! boilerplate_ultisnips#InsertSkeletonIfEmpty() abort
  let filename = expand('%')

  " Abort on non-empty buffer or extant file
  if !(line('$') == 1 && getline('$') == '') || filereadable(filename)
    return
  endif

  call boilerplate_ultisnips#InsertSkeleton()
endfunction
