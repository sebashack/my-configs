call plug#begin('~/.config/nvim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" set shadafile=/home/sebastian/.local/share/nvim/shada/main.shada
set encoding=utf-8
set ignorecase
set smartcase
set softtabstop=2
set shiftwidth=2
set expandtab
autocmd BufRead,BufNewFile *.CPP setlocal ft=cpp
highlight Pmenu ctermbg=gray guibg=white

"" TypeScript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/denite.nvim'
Plug 'pangloss/vim-javascript'

"" PureScript
Plug 'purescript-contrib/purescript-vim'
syntax on
filetype on
filetype plugin indent on

""  Sem's footprint in Sebastian's nvim realm
set list!
set listchars=tab:>-,trail:∙

"" Hindent and FZF set up
setlocal formatprg=hindent
set rtp+=~/.fzf

"" Some FZF bindings
nnoremap <silent> <space> :FZF<space>
nnoremap <silent> <space><space> :FZF <cr>

" Jump to next/previous merge conflict marker
nnoremap <silent> ]c /\v^(\<\|\=\|\>){7}([^=].+)?$<cr>
nnoremap <silent> [c ?\v^(\<\|\=\|\>){7}([^=].+)\?$<cr>

" Quickly go to next or previous buffer
nnoremap <silent> <tab>l :bn<cr>
nnoremap <silent> <tab>h :bN<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""" Swift
Plug 'keith/swift.vim'

""""""" Scala
Plug 'derekwyatt/vim-scala'
let g:scala_scaladoc_indent = 1

""""""" Clang format
Plug 'rhysd/vim-clang-format'

""""""" Appearance
Plug 'frankier/neovim-colors-solarized-truecolor-only' " Solarized colorscheme {{{
set termguicolors
set background=dark
" }}}

""""""" Reason
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' } " Language Server Protocol (LSP) {{{
Plug 'reasonml-editor/vim-reason-plus'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" }}}

let g:LanguageClient_serverCommands = {
      \ 'reason': ['/home/sebastian/.local/bin/reason-language-server.exe'],
      \ }

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>

""""""" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='minimalist'
" }}}

call plug#end()
