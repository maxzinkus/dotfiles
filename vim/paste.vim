" copying and pasting
noremap <leader>pp :setlocal paste!<cr>
" copy visual highlight to clipboard ("+ and "* don't seem to do it)
" pbpaste because pbcopy doesn't output anything, so w/o it the highlight is
" deleted
noremap <leader>cp !pbcopy; pbpaste<cr>
" toggle numbering for pointer selection
noremap <leader>nn :set number!<cr>:set relativenumber!<cr>
