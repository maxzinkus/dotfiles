source ~/.config/vim/general.vim
source ~/.config/vim/code.vim
source ~/.config/vim/splits.vim
source ~/.config/vim/paste.vim
source ~/.config/vim/spell.vim
source ~/.config/vim/statusbar.vim

" Vimdiff
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif
noremap <leader>1 :diffget LOCAL; diffupdate<cr>
noremap <leader>2 :diffget BASE; diffupdate<cr>
noremap <leader>3 :diffget REMOTE; diffupdate<cr>
" git mergetool
" :diffget LOCAL == accept local branch's changes
" :diffget BASE == reject both local and remote changes
" :diffget REMTOE == accept remote branch's changes
" :wqa to accept and quit
" :cq to reject and quit

" Colorizer plugin
let g:colorizer_fgcontrast=1
noremap <leader>ct :ColorToggle<cr>

" VimWiki
let g:vimwiki_list = [{'path': '~/.vimwiki', 'path_html': '~/Documents/VimWiki'}]

" Load plugins and generate help tags for everything
packloadall
silent! helptags ALL
