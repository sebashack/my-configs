call plug#begin('~/.config/nvim/plugged')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""" MiniZinc
Plug 'vale1410/vim-minizinc'

""""""" Python
" Plug 'w0rp/ale'

""""""" Scala
Plug 'derekwyatt/vim-scala'
let g:scala_scaladoc_indent = 1

""""""" Clang format
Plug 'rhysd/vim-clang-format'

""""""" Appearance
Plug 'frankier/neovim-colors-solarized-truecolor-only' " Solarized colorscheme {{{
set termguicolors
set background=dark

""""""" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='minimalist'

""""""" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
call plug#end()

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
set noswapfile

autocmd BufRead,BufNewFile *.CPP setlocal ft=cpp
highlight Pmenu ctermbg=gray guibg=white

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

" Rust
autocmd BufRead,BufNewFile *.rs syntax enable
autocmd BufRead,BufNewFile *.rs filetype plugin indent on

" Set completeopt to have a better completion experience
autocmd BufRead,BufNewFile *.rs set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
autocmd BufRead,BufNewFile *.rs set shortmess+=c

"""""""""""""""""""""""""RUST"""""""""""""""""""""""""""

" Configure lsp
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)
EOF

autocmd BufRead,BufNewFile *.rs nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
autocmd BufRead,BufNewFile *.rs nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
autocmd BufRead,BufNewFile *.rs nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
autocmd BufRead,BufNewFile *.rs nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
autocmd BufRead,BufNewFile *.rs nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
autocmd BufRead,BufNewFile *.rs nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
autocmd BufRead,BufNewFile *.rs nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
autocmd BufRead,BufNewFile *.rs set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold *.rs lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
autocmd BufRead,BufNewFile *.rs nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
autocmd BufRead,BufNewFile *.rs nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
autocmd BufRead,BufNewFile *.rs set signcolumn=yes

"""""""""""""""""""""""""PYTHON"""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.py set tabstop=4
autocmd BufRead,BufNewFile *.py set softtabstop=4
autocmd BufRead,BufNewFile *.py set shiftwidth=4
autocmd BufRead,BufNewFile *.py set expandtab
autocmd BufRead,BufNewFile *.py set autoindent
autocmd BufRead,BufNewFile *.py set fileformat=unix
autocmd BufRead,BufNewFile *.py syntax on
autocmd BufRead,BufNewFile *.py syntax enable

 " ALE vars
autocmd BufRead,BufNewFile *.py let g:ale_lint_on_enter = 0
autocmd BufRead,BufNewFile *.py let g:ale_disable_lsp = 1
autocmd BufRead,BufNewFile *.py let g:ale_linters = {'python': ['flake8']}
autocmd BufRead,BufNewFile *.py let g:ale_fixers = { 'python': ['black'] }
autocmd BufRead,BufNewFile *.py let g:ale_lint_on_text_changed = 'never'
autocmd BufRead,BufNewFile *.py let g:ale_echo_msg_error_str = 'E'
autocmd BufRead,BufNewFile *.py let g:ale_echo_msg_warning_str = 'W'
autocmd BufRead,BufNewFile *.py let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
