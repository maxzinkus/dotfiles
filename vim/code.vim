" code-specific configs

" + to write out buffers and run make
nnoremap + :wa<bar>:make<bar><cr>

" Indentation and other settings for common languages/formats
set shiftwidth=3
set tabstop=3
set smartindent
set smarttab
set expandtab
set breakindent
set foldmethod=indent
" don't highlight long lines
set synmaxcol=256

" Folding
" space bar toggles fold open/closed
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<cr>
vnoremap <Space> zf
" style folded sections
function! MyFoldText()
    let line = getline(v:foldstart)
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart
    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - strdisplaywidth(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()
highlight Folded ctermfg=darkgrey ctermbg=NONE
" start with folding off unless file is large
setlocal nofoldenable
function Detectfold()
   if line('$') > winheight(0)
      setlocal foldenable
   else
      setlocal nofoldenable
   endif
endfunction
au VimEnter * :call Detectfold()

if has("autocmd")
    filetype plugin indent on
    autocmd FileType py,python,hs setlocal shiftwidth=4 tabstop=4 colorcolumn=80
    autocmd FileType c,h,java,cpp,hpp,rust,sh,css,js,go setlocal shiftwidth=3 tabstop=3 colorcolumn=80
    autocmd FileType rust nnoremap + :wa<bar>:!cargo build<cr>
    autocmd FileType html,xml,markdown,md,txt,text setlocal shiftwidth=2 tabstop=2 colorcolumn=80
    autocmd FileType markdown,md,txt,text setlocal textwidth=80 nofoldenable
endif

" toggle folding
noremap <leader>ff :set foldenable!<cr>

" shortcut to CamelCase a word
" capitalizes the letter under the cursor, and the first letter
noremap cc vUbvU
