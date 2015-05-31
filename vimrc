" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'wakatime/vim-wakatime'

call vundle#end()

" Syntax highlighting & filetype detection
syntax enable
filetype plugin indent on

" Easier to reach leader key
let mapleader=','

" This causes you to not be able to delete stuff otherwise, sometimes
set backspace=indent,eol,start

" Share clipboard with OSX
set clipboard=unnamed

" Spell check language
set spelllang=en_gb

" Use UTF-8 encoding
set encoding=utf-8

" Don't update screen while executing macros
set lazyredraw

" Reload files when changed externally
set autoread

" Don't use modelines
set modelines=0

" Turn off backups and swap files
set nobackup noswapfile nowb

" Always open new windows on the right/bottom
set splitright splitbelow

" Ignore
set wildignore+=*/tmp/*,*/.sass-cache/*,*/node_modules/*,*/.git/*,*.so,*.swp,*.zip,*/_site/*

" }}}
" 2. Plugins -------------------------------------------------------------- {{{

" ctrlp
let g:ctrlp_split_window = 0

" syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=2
let g:syntastic_enable_signs=0
let g:syntastic_enable_highlighting=0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['javascript', 'json', 'ruby'], 'passive_filetypes': [] }

" indent line
let g:indentLine_color_term = 234
let g:indentLine_char = '│'

" NERDTree
let g:NERDTreeWinSize=50

" }}}
" 3. Interface ------------------------------------------------------------ {{{

" 256 color mode
set t_Co=256

" Colorscheme
colo bryantebeek
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Highlight current line only for active window
autocmd BufWinEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Always show status line
set laststatus=2

" Update the title bar
set title

" Start scrolling before reaching buffer edges
set scrolloff=5
set sidescrolloff=7
set sidescroll=1

" Search stuff
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
set hlsearch
set incsearch
set ignorecase smartcase

" Diffs
set diffopt=filler
set diffopt+=iwhite

" Folding
set foldmethod=indent
set foldlevelstart=99
set foldnestmax=3
set nofoldenable

" Enable line numbers
set number

" No sound effects
set noerrorbells
set visualbell

" Toggle paste mode in insert mode
set pastetoggle=<leader>p

" }}}
" 4. Indentation ---------------------------------------------------------- {{{

" Set tab display as four spaces, don't expand
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Auto indent stuff
set autoindent smartindent
set copyindent

" Don't wrap lines
set nowrap

" }}}
" 5. Keybinds ------------------------------------------------------------- {{{

" NerdTree
map <leader>m :NERDTreeToggle<CR>
map <leader>n :NERDTreeFind<CR>

" Disable dem arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Easier buffer switching
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

" Faster scrolling
nnoremap <C-e> 10<C-e>
nnoremap <C-y> 10<C-y>

" Auto-center search results
nmap n nzz
nmap N Nzz

" Fold with space
nnoremap <space> za
vnoremap <space> zf

" Quickly edit/reload the vimrc file
noremap <leader>ev <c-w><c-v><c-l>:e $MYVIMRC<cr>

" Make tab indent in visual mode, and shift tab undent
vmap <tab> >gv
vmap <s-tab> <gv

" Easier commands
nnoremap ; :

" Escape mode
inoremap jj <ESC>

" Tab completion
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" }}}
" 6. File types ----------------------------------------------------------- {{{

" Easier buffer resizing
nmap < 5<C-w><
nmap - 5<C-w>-
nmap + <C-w>+
nmap > <C-w>>

" Set Capfile, Gemfile and Vagrantfile as Ruby
au BufRead,BufNewFile Capfile set filetype=ruby
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile Vagrantfile set filetype=ruby

" Wrap Markdown files
au BufRead,BufNewFile *.md setl wrap tw=80 sw=2 sts=2 et

" }}}
" 7. Functions ------------------------------------------------------------ {{{

" Trim whitespace off line-endings on save
autocmd BufWritePre * :call StripWhitespace()
function! StripWhitespace ()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction

" When editing a file, always jump to the last known cursor position
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif

" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
