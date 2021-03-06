" AUTHOR: kanno <akapanna@gmail.com>
" MAINTAINER: previm developers
" License: This file is placed in the public domain.

if exists('g:loaded_previm') && g:loaded_previm
  finish
endif
let g:loaded_previm = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:install_previm() abort
  augroup Previm
    autocmd! * <buffer>
    if get(g:, 'previm_enable_realtime', 0) ==# 1
      " NOTE: It is too frequently in TextChanged/TextChangedI
      autocmd CursorHold,CursorHoldI,InsertLeave,BufWritePost <buffer> call previm#refresh()
    else
      autocmd BufWritePost <buffer> call previm#refresh()
    endif
  augroup END

  command! -buffer -nargs=0 PrevimOpen call previm#open1()
  command! -buffer -nargs=0 PrevimLocal call previm#open2()
  command! -buffer -nargs=0 PrevimBook call previm#book()
  command! -buffer -nargs=0 PrevimLinked call previm#linked()
  command! -buffer -nargs=0 PrevimPatch call previm#patchdir()
  command! -buffer -nargs=0 PrevimWipeCache call previm#wipe_cache()
endfunction

augroup Previm
  autocmd!
  autocmd FileType *{mkd,markdown,rst,textile,asciidoc}* call <SID>install_previm()
augroup END

let &cpo = s:save_cpo
unlet! s:save_cpo
