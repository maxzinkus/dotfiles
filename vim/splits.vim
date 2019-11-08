" splits and buffers
" Splits
" super speedy splits
noremap <leader>v :vsplit<cr>
noremap <leader>b :split<cr>
noremap <leader>x :bd<cr>
" Navigate splits quickly
noremap <LEFT> <C-w>h
noremap <DOWN> <C-w>j
noremap <UP> <C-w>k
noremap <RIGHT> <C-w>l
" open without replacing current view
set splitright
set splitbelow
" resize splits automatically
au VimResized * :wincmd =

" Buffers and fzf
set rtp+=~/.fzf
nmap ; :Buffers<cr>
nmap <leader>e :Files<cr>
nmap <leader>r :Marks<cr>
nmap <leader>t :Tags<cr>
" move between open buffers
map <PageDown> :bnext<cr>
map <PageUp> :bprev<cr>

" Netrw
" When browsing a directory, display a tree (toggle dirs with <cr>)
let g:netrw_liststyle=3
" When browsing a directory, default to opening in a vertical split
let g:netrw_browse_split=2
