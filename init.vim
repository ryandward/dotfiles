set t_Co=16

" General settings
set number                  " Show line numbers
set wrap                    " Wrap long lines
set noexpandtab             " Use tabs instead of spaces
set autoindent              " Auto-indent new lines
set cursorline              " Highlight the cursor line
set showmatch               " Highlight matching brackets
set ignorecase              " Ignore case when searching
set smartcase               " Override 'ignorecase' if the search pattern contains uppercase characters
set incsearch               " Incremental search
set hlsearch                " Highlight search results
set hidden                  " Enable switching between unsaved buffers
set undodir=~/.config/nvim/undo " Set directory for persistent undo
set undofile                " Enable persistent undo
set completeopt=menuone,noinsert,noselect " Better completion behavior
set shortmess+=c            " Don't show completion messages


call plug#begin('~/.local/share/nvim/plugged')

" Add vim-airline plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Add NERDTree plugin
Plug 'preservim/nerdtree'

" Add fzf and fzf.vim plugins
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Add vim-surround plugin
Plug 'tpope/vim-surround'

" Add vim-commentary plugin
Plug 'tpope/vim-commentary'

" Add vim-gitgutter plugin
Plug 'airblade/vim-gitgutter'

" Add vim-fugitive plugin
Plug 'tpope/vim-fugitive'

" Add vim-polyglot plugin
Plug 'sheerun/vim-polyglot'

" Add coc.nvim plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let g:airline_powerline_fonts = 1

" Set up fzf keybindings
nnoremap <C-p> :Files<CR>

" Set up NERDTree keybindings
nnoremap <C-n> :NERDTreeToggle<CR>

" Set up coc.nvim configuration
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-python',
  \ 'coc-yaml',
  \ 'coc-git',
  \ 'coc-eslint',
  \ 'coc-prettier'
  \ ]

" Set up airline theme
" let g:airline_theme = 'your_airline_theme_here'

let g:airline_powerline_fonts = 1

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <CR> to confirm completion
inoremap <expr> <CR>    pumvisible() ? coc#_select_confirm() : "\<CR>"

