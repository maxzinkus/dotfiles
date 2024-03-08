" vimrc General vim behavior and mappings
"{{{
" basic settings
set nocompatible
set backspace=indent,eol,start
set termguicolors
" push more characters through to the terminal per cycle
set ttyfast
" don't update the screen during commands
set lazyredraw
" auto-update if changes are detected
set autoread
" colors!
set background=dark
colorscheme onedark
" disable mouse
set mouse=""
" disable intro text
set shortmess+=I
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
" hidden tags file
set tags+=.tags;expand('~');/
" U is a reasonable inverse of u
nnoremap U <C-R>
" <count><C-e> moves the content <count> lines up
" so <count><C-d> can move it down
noremap <C-d> <C-y>
" make Y behave like other linewise operations
nnoremap Y y$
" I never use Ex mode, so re-run macros instead
nnoremap Q @@
" behavior for line numbers and current line
set rnu
set number
" sane movement through wrapping lines
noremap j gj
noremap k gk
" shortcut to CamelCase a word
" capitalizes the letter under the cursor, and the first letter
noremap cc vUbvU
" Exiting
noremap <leader>q :wq<cr>
" sometimes I get off the shift key too slowly
command W w
command Q q
command Wq wq
command WQ wq
if filereadable(expand('~/.vim/vimrc.d/vimrc_custom_basic'))
    runtime vimrc.d/vimrc_custom_basic
endif
"}}}
" General (Settings, Folding, Autocmd)
"{{{
" - Settings
"{{{
" + to write out buffers and run make
nnoremap + :wa<bar>:make<bar><cr>
" Show matching brackets
set showmatch
" Matching settings
set ignorecase
set smartcase
set incsearch
" Indentation and other settings for common languages/formats
set shiftwidth=2
set tabstop=2
set smartindent
set smarttab
set expandtab
set breakindent
set foldmethod=indent
" don't highlight long lines
set synmaxcol=1024
"}}}
" - Folding
"{{{
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
" start with folding off unless it has been manually toggled in this buffer
setlocal nofoldenable
autocmd BufEnter * if !exists('b:foldmanual') | setlocal nofoldenable | endif
" toggle folding and remember that we took manual control in this buffer
noremap <leader>ff :set foldenable! <bar> :let b:foldmanual=1<cr>
" save/restore manual folds
noremap <leader>fs :mkview<cr>
noremap <leader>fl :loadview<cr>
"}}}
" - Autocmd
"{{{
" File type configurations
autocmd FileType py,python,hs setlocal shiftwidth=4 tabstop=4
autocmd FileType c,h,java,cpp,hpp,rust,sh,css,js,go setlocal shiftwidth=3 tabstop=3
autocmd FileType rust nnoremap <buffer> + :wa<bar>:!cargo build<cr>
autocmd FileType html,xml,markdown,md,txt,text setlocal shiftwidth=2 tabstop=2
autocmd FileType markdown,md,txt,text setlocal nofoldenable spell spelllang=en_us
autocmd FileType gitcommit setlocal shiftwidth=2 tabstop=2 colorcolumn=73 nofoldenable spell spelllang=en_us
autocmd FileType gitconfig setlocal shiftwidth=4 tabstop=4
autocmd FileType git setlocal nomodeline
autocmd FileType vim setlocal shiftwidth=4 tabstop=4 foldmethod=marker foldmarker=\"{{{,\"}}}
autocmd FileType zsh setlocal nofoldenable
autocmd FileType tex,plaintex setlocal foldmethod=marker foldmarker=%{{{,%}}} spell spelllang=en_us
autocmd FileType ale-preview setlocal nofoldenable
autocmd FileType make setlocal shiftwidth=8 tabstop=8
filetype plugin indent on
"}}}
"}}}
" Splits
"{{{
" super speedy splits
noremap <leader>v :vnew<cr>
noremap <leader>V :vsplit<cr>
noremap <leader><cr> :new<cr>
noremap <leader>x :BD<cr>
" Navigate splits quickly
noremap <LEFT> <C-w>h
noremap <DOWN> <C-w>j
noremap <UP> <C-w>k
noremap <RIGHT> <C-w>l
" open without replacing current view
set splitright
set splitbelow
if filereadable(expand('~/.vim/vimrc.d/vimrc_custom_splits'))
    runtime vimrc.d/vimrc_custom_splits
endif
"}}}
" Epilogue
"{{{
" Load plugins and generate help tags for everything - must be at end
if filereadable(expand('~/.vim/vimrc.d/vimrc_custom_plugins'))
    runtime vimrc.d/vimrc_custom_plugins
endif
packloadall
silent! helptags ALL
set secure
if filereadable(expand('~/.vim/vimrc.d/vimrc_custom_postrc'))
    runtime vimrc.d/vimrc_custom_postrc
endif
"}}}
