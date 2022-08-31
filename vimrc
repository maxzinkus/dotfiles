" vimrc General vim behavior and mappings
"{{{
set nocompatible
set backspace=indent,eol,start
set termguicolors
" push more characters through to the terminal per cycle
set ttyfast
" don't update the screen during commands
set lazyredraw
" auto-update if changes are detected
set autoread
" auto-cd to working file dir
set autochdir
" colors!
set background=dark
colorscheme gruvbox
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
set tags+=.tags
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
" Current line highlighting
set cursorlineopt=number
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
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
" Reopen at last closed line
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
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
" start with folding off, and turn off if opening a diff split
setlocal nofoldenable
autocmd VimEnter * if &diff | setlocal nofoldenable | endif
" toggle folding
noremap <leader>ff :set foldenable!<cr>
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
autocmd FileType vim setlocal shiftwidth=4 tabstop=4 foldmethod=marker foldmarker=\"{{{,\"}}}
autocmd FileType zsh setlocal nofoldenable
autocmd FileType vimwiki setlocal modeline spell spelllang=en_us
autocmd FileType tex,plaintex setlocal foldmethod=marker foldmarker=%{{{,%}}} spell spelllang=en_us
autocmd FileType ale-preview setlocal nofoldenable
autocmd FileType make setlocal shiftwidth=8 tabstop=8
filetype plugin indent on
"}}}
"}}}
" Splits
"{{{
" super speedy splits
noremap <leader>v :vsplit<cr>
noremap <leader>x :BD<cr>
" Navigate splits quickly
noremap <LEFT> <C-w>h
noremap <DOWN> <C-w>j
noremap <UP> <C-w>k
noremap <RIGHT> <C-w>l
" open without replacing current view
set splitright
set splitbelow
" minimum width for NERDTree and Tagbar panes to open
let minPaneWidth=116
let minDoublePaneWidth=216
function s:CheckClosePanes()
    if &columns < minDoublePaneWidth
        execute "TagbarClose"
        if &columns < minPaneWidth
            execute "NERDTreeClose"
        endif
    else
        execute "NERDTree | wincmd p"
        call tagbar#autoopen(1)
    endif
endfunction
au VimResized * :call s:CheckClosePanes()
"}}}
" Buffers and fzf
"{{{
set rtp+=/opt/homebrew/opt/fzf
nmap ; :Buffers<cr>
nmap <leader>e :Files<cr>
nmap <leader>r :Marks<cr>
nmap <leader>t :Tags<cr>
nmap <C-\> <C-^>
" move between open buffers
map <Home> :bprev<cr>
map <End> :bnext<cr>
"}}}
" Plugins and external programs
"{{{
" - man
"{{{
runtime ftplugin/man.vim
set keywordprg=:Man
"}}}
" - netrw
"{{{
" when browsing a directory, display a tree (toggle dirs with <cr>)
let g:netrw_liststyle=3
" when browsing a directory, default to opening in a vertical split
let g:netrw_browse_split=2
" copying and pasting
"}}}
" - copy/paste
"{{{
noremap <leader>p :setlocal paste!<cr>
" copy visual highlight to clipboard ("+ and "* don't seem to do it)
" pbpaste because pbcopy doesn't output anything, so w/o it the highlight is
" deleted
noremap <leader>cp !pbcopy; pbpaste<cr>
" toggle numbering for pointer selection
noremap <leader>n :set number!<cr>:set relativenumber!<cr>
"}}}
" - Spelling and completion
"{{{
" toggle spellcheck
noremap <leader>ss :setlocal spell!<cr>
set spelllang=en_us
" somewhat saner spell shortcuts
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>s? z=
noremap <leader>sa zg
set spellfile=~/.vim/spell/en.utf-8.add
set wildmenu
set wildignorecase
set complete+=kspell
set infercase
"}}}
" - ALE
"{{{
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
let g:ale_python_pylint_options = '-d protected-access'
let g:ale_open_list = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
nmap <leader>ll :ALEToggle<cr>
nmap <leader>ln :ALENext<cr>
nmap <leader>lp :ALEPrevious<cr>
" close the window if the quickfix is the last open pane
aug QFClose
  au!
  au WinEnter * if (winnr('$') == 1 || (winnr('$') == 2 && exists('g:NERDTree') && g:NERDTree.IsOpen())) && &buftype == "quickfix"|q|endif
aug END
"}}}
" - Bufferline
"{{{
let g:bufferline_echo = 0
"}}}
" - Lightline
"{{{
set laststatus=2
set noshowmode
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [['mode', 'paste'], ['filename', 'modified', 'readonly'], ['bufferline']],
            \   'right': [['lineinfo'], ['percent'], ['linter_warnings', 'linter_errors', 'linter_ok']]
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
            \ 'component_function': {
            \   'bufferline': 'MyBufferline'
            \ },
            \}
function! MyBufferline()
    call bufferline#refresh_status()
    let b = g:bufferline_status_info.before
    let c = g:bufferline_status_info.current
    let a = g:bufferline_status_info.after
    let alen = strlen(a)
    let blen = strlen(b)
    let clen = strlen(c)
    let w = winwidth(0) * 4 / 10
    if w < alen+blen+clen
        let whalf = (w - strlen(c)) / 2
        let aa = alen > whalf && blen > whalf ? a[:whalf] : alen + blen < w - clen || alen < whalf ? a : a[:(w - clen - blen)]
        let bb = alen > whalf && blen > whalf ? b[-(whalf):] : alen + blen < w - clen || blen < whalf ? b : b[-(w - clen - alen):]
        return (strlen(bb) < strlen(b) ? '...' : '') . bb . c . aa . (strlen(aa) < strlen(a) ? '...' : '')
    else
        return b . c . a
    endif
endfunction

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
    return (g:ale_enabled && l:counts.total == 0) ? '✓ ' : ''
endfunction

augroup lightline#ale
    autocmd!
    autocmd User ALEJobStarted call lightline#update()
    autocmd User ALELintPost call lightline#update()
    autocmd User ALEFixPost call lightline#update()
augroup END
"}}}
" - NERDTree
"{{{
noremap <C-n> :NERDTreeToggle<cr>
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * if &columns > minPaneWidth | NERDTree | wincmd p | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"}}}
" - tagbar
"{{{
nmap <C-t> :TagbarToggle<cr>
autocmd VimEnter * nested if &columns > minPaneWidth | call tagbar#autoopen(1) | endif
"}}}
" - Vimdiff
"{{{
noremap <leader>1 :diffget LOCAL; diffupdate<cr>
noremap <leader>2 :diffget BASE; diffupdate<cr>
noremap <leader>3 :diffget REMOTE; diffupdate<cr>
" git mergetool
" :diffget LOCAL == accept local branch's changes
" :diffget BASE == reject both local and remote changes
" :diffget REMTOE == accept remote branch's changes
" :wqa to accept and quit
" :cq to reject and quit
"}}}
" - VimWiki
"{{{
let g:vimwiki_global_ext = 0 " disable vimwiki outside vimwiki directory
let g:vimwiki_list = [{'path': '~/.vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
"}}}
"}}}
" Epilogue
"{{{
" Load plugins and generate help tags for everything - must be at end
packloadall
silent! helptags ALL
set secure
" Set transparency after plugins loaded in case of overridden bg
hi Normal guibg=NONE ctermbg=NONE
hi CursorLineNr ctermbg=NONE guibg=NONE
hi Todo ctermbg=NONE guibg=NONE
"}}}
