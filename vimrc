" push more characters through to the terminal per cycle
set ttyfast

" indent settings for common languages
set shiftwidth=4
set tabstop=4
set smartindent
set smarttab
set expandtab
set breakindent
if has("autocmd")
    filetype plugin indent on
    autocmd FileType py,python,hs setlocal shiftwidth=4 tabstop=4 colorcolumn=80 foldmethod=indent
    autocmd FileType c,h,java,cpp,hpp,rs,sh,css,js,go setlocal shiftwidth=3 tabstop=3 colorcolumn=80 foldmethod=indent
    autocmd FileType html,xml,markdown,md setlocal shiftwidth=2 tabstop=2 colorcolumn=120
endif

set synmaxcol=1024

" make command/keycode timeouts behave reasonably
set notimeout
set ttimeout
set ttimeoutlen=10

" don't leave a mess
set backup
set backupdir=~/.vim/backup
set noswapfile
set backupskip=/tmp/*
au VimResized * :wincmd =

set background=dark

" disable mouse
set mouse=""

" set behavior for line numbers and current line
set rnu
set number
set cursorline

" Don't go to Ex mode
map Q <Nop>

"Pasting should be at the right indent level
map p ]p
map P ]P

" + save all and compiles (runs make)
nnoremap + :wa<bar>:make<bar><CR>

" sometimes I get off the shift key too slowly
command W w
command Q q
command Wq wq
command WQ wq

set autoread

let mapleader = ","
noremap <leader>v :vsplit<cr>
noremap <leader>b :split<cr>
noremap <leader>q :wq<cr>
noremap <leader>ff :set foldenable!<cr>
noremap <leader>pp :setlocal paste!<cr>
noremap <leader>cp !pbcopy; pbpaste<cr>
noremap <leader>ss :setlocal spell!<cr>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>s? z=
noremap <leader>sa zg
set spellfile=~/.vim/spell/en.utf-8.add

set splitright
set splitbelow

" Move between open buffers.
map <PageDown> :bnext<CR>
map <PageUp> :bprev<CR>

set rtp+=~/.fzf
nmap ; :Buffers<cr>
nmap <leader>e :Files<cr>
nmap <leader>r :Tags<cr>

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
nmap <leader>ll :ALEToggle<cr>

" Lightline
set laststatus=2
set noshowmode
if has('gui_running')
    set t_Co=256
endif
let g:lightline = {
            \ 'active': {
            \   'left': [['mode', 'paste'], ['filename', 'modified']],
            \   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
            \ },
            \ 'component_expand': {
            \   'linter_warnings': 'LightlineLinterWarnings',
            \   'linter_errors': 'LightlineLinterErrors',
            \   'linter_ok': 'LightlineLinterOK'
            \ },
            \ 'component_type': {
            \   'readonly': 'error',
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error'
            \ },
            \ }

noremap j gj
noremap k gk
noremap <UP> gk
noremap <DOWN> gj

noremap <C-LEFT> <C-w>h
noremap <C-DOWN> <C-w>j
noremap <C-UP> <C-w>k
noremap <C-RIGHT> <C-w>l

function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '✓ ' : ''
endfunction

augroup lightline#ale
    autocmd!
    autocmd User ALEJobStarted call lightline#update()
    autocmd User ALELintPost call lightline#update()
    autocmd User ALEFixPost call lightline#update()
augroup END

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
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
set nofoldenable

packloadall
silent! helptags ALL
