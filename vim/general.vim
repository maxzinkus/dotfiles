" general vim behavior and mappings
" push more characters through to the terminal per cycle
set ttyfast

" auto-update if changes are detected
set autoread

" make colors vibrant
set background=dark
source ~/.vim/happy_hacking.vim

" disable mouse
set mouse=""

" make command/keycode timeouts behave reasonably
set notimeout
set ttimeout
set ttimeoutlen=10

" assume s/../../g
set gdefault

" so much more convenient
let mapleader = ","

" don't leave a mess
set backup
set backupdir=~/.vim/backup
set noswapfile
set backupskip=/tmp/*

" behavior for line numbers and current line
set rnu
set number
set cursorline

" sane movement through wrapping lines
noremap j gj
noremap k gk

" Don't go to Ex mode
map Q <Nop>

" Exiting
noremap <leader>q :wq<cr>
" sometimes I get off the shift key too slowly
command W w
command Q q
command Wq wq
command WQ wq

