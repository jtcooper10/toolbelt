" Custom keybindings
let mapleader = ";"
" Vim config edits: always start with v
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
nnoremap <leader>vr <CR>:source $MYVIMRC<CR>
nnoremap <leader>vi :PlugInstall<CR>
nnoremap <c-n> :NERDTreeToggle<CR>
" Text editing mappings
" Insert semicolon at end of the line
nnoremap <leader>; $a;<esc>
" Jump to end of first paragraph; intended for adding new #includes
nnoremap <leader>H gg}O
