" push more characters through to the terminal per cycle
set ttyfast

" auto-update if changes are detected
set autoread

" make colors vibrant
set background=dark

" disable mouse
set mouse=""

" assume s/../../g
set gdefault

" so much more convenient
let mapleader = ","

" behavior for line numbers and current line
set rnu
set number
set cursorline

" + to write out buffers and run make
nnoremap + :wa<bar>:make<bar><CR>

" Indentation and other settings for common languages/formats
set shiftwidth=4
set tabstop=4
set smartindent
set smarttab
set expandtab
set breakindent
set foldmethod=indent
" don't highlight long lines
set synmaxcol=1024

if has("autocmd")
    filetype plugin indent on
    autocmd FileType py,python,hs setlocal colorcolumn=80
    autocmd FileType c,h,java,cpp,hpp,rust,sh,css,js,go setlocal shiftwidth=3 tabstop=3 colorcolumn=80
    autocmd FileType rust nnoremap + :wa<bar>:!cargo build<CR>
    autocmd FileType html,xml,markdown,md,txt,text setlocal shiftwidth=2 tabstop=2 colorcolumn=80 textwidth=80
endif

" Folding
" space bar toggles fold open/closed
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
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
" start with folding off
set nofoldenable
" toggle folding
noremap <leader>ff :set foldenable!<cr>

" make command/keycode timeouts behave reasonably
set notimeout
set ttimeout
set ttimeoutlen=10

" don't leave a mess
set backup
set backupdir=~/.vim/backup
set noswapfile
set backupskip=/tmp/*

" sane movement through wrapping lines
noremap j gj
noremap k gk
noremap <UP> gk
noremap <DOWN> gj

" Don't go to Ex mode
map Q <Nop>

" Exiting
noremap <leader>q :wq<cr>
" sometimes I get off the shift key too slowly
command W w
command Q q
command Wq wq
command WQ wq

" Splits
" super speedy splits
noremap <leader>v :vsplit<cr>
noremap <leader>b :split<cr>
" Navigate splits quickly
noremap <C-LEFT> <C-w>h
noremap <C-DOWN> <C-w>j
noremap <C-UP> <C-w>k
noremap <C-RIGHT> <C-w>l
" open without replacing current view
set splitright
set splitbelow
" resize splits automatically
au VimResized * :wincmd =

" Pasting
noremap <leader>pp :setlocal paste!<cr>
" copy visual highlight to clipboard ("+ and "* don't seem to do it)
" pbpaste because pbcopy doesn't output anything, so w/o it the highlight is
" deleted
noremap <leader>cp !pbcopy; pbpaste<cr>

" Vimdiff
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif
" git mergetool
" :diffget LOCAL == accept local branch's changes
" :diffget BASE == reject both local and remote changes
" :diffget REMTOE == accept remote branch's changes
" :wqa to accept and quit
" :cq to reject and quit

" Spellcheck
" toggle spellcheck
noremap <leader>ss :setlocal spell!<cr>
" somewhat saner spell shortcuts
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>s? z=
noremap <leader>sa zg
set spellfile=~/.vim/spell/en.utf-8.add

" Buffers and fzf
set rtp+=~/.fzf
nmap ; :Buffers<cr>
nmap <leader>e :Files<cr>
nmap <leader>r :Marks<cr>
nmap <leader>t :Tags<cr>
" move between open buffers
map <PageDown> :bnext<CR>
map <PageUp> :bprev<CR>

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
" /Lightline

" Load plugins and generate help tags for everything
packloadall
silent! helptags ALL
