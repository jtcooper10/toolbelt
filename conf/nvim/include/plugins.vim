call plug#begin()
" Terminal QOL plugins
Plug 'powerline/powerline'
Plug 'scrooloose/nerdtree'
" Linters and autocorrects
Plug 'maxmellon/vim-jsx-pretty'
" Autocomplete, etc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'moll/vim-node'
Plug 'jparise/vim-graphql'
" Themes and visuals
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'NLKNguyen/papercolor-theme'
" Language-specific
Plug 'Yohannfra/Vim-Goto-Header'
" Plug 'bfrg/vim-cpp-modern'
Plug 'leafgarland/typescript-vim'
call plug#end()
" set runtimepath^=~/.vim/bundle/node

" GOTO header for C/C++
let g:goto_header_include_dirs = [".", "/usr/include", "..", "~" ]
let g:goto_header_use_find = 1

