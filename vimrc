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
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'

call vundle#end()

" Syntax highlighting & filetype detection
syntax enable
filetype plugin indent on

" Easier to reach leader key
let mapleader=','

" This causes you to not be able to delete stuff otherwise, sometimes
set backspace=2

" Share clipboard with OSX
set clipboard=unnamed

" Spell check language
set spelllang=en_gb

" BOM can cause some errors sometimes
set encoding=utf-8 nobomb

" Don't update display while executing macros
set lazyredraw

" Reload files when changed externally
set autoread

" Don't use modelines
set modelines=0

" Turn off backups and swap files
set nobackup noswapfile nowb

" Always open new windows on the right/bottom
set splitright splitbelow

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

" }}}
" 3. Interface ------------------------------------------------------------ {{{

" 256 color mode
set t_Co=256

" Colorscheme
colo hardcore

" No line numbers
set nonumber

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

" Show tab characters & when a line is too long
set list
set listchars=tab:\|\ ,trail:·,extends:❯,precedes:❮

" Change StatusLine colors
hi StatusLine ctermfg=233
hi StatusLine ctermbg=red

" Line numbers
set number
hi LineNr ctermbg=NONE

" No sound effects
set noerrorbells
set visualbell

" Toggle paste mode in insert mode
set pastetoggle=<leader>p

" Format the statusline
set statusline=%{HasPaste()}%f\ %m%r%h\ \ \ \ \ Col:\ %c\ \ \ Row:\ %l/%L\ -\ %p%%

function! HasPaste()
	if &paste
		return 'PASTE '
	else
		return ''
	endif
endfunction

" }}}
" 4. Indentation ---------------------------------------------------------- {{{

" Set tab display as four spaces, don't expand
set shiftwidth=2
set tabstop=2
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
map <leader>k :NERDTreeToggle<CR>

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

" Easier tab switching
nmap <esc>1 1gt
nmap <esc>2 2gt
nmap <esc>3 3gt
nmap <esc>4 4gt
nmap <esc>5 5gt
nmap <esc>6 6gt
nmap <esc>7 7gt
nmap <esc>8 8gt
nmap <esc>9 9gt

" Faster scrolling
nnoremap <C-e> 10<C-e>
nnoremap <C-y> 10<C-y>

" Duplicate line
noremap <leader>dd Yp
noremap <leader>du YP

" Easier buffer resizing
nmap < 5<C-w><
nmap - 5<C-w>-
nmap + 5<C-w>+
nmap > 5<C-w>>

" Auto-center search results
nmap n nzz
nmap N Nzz

" Fold with space
nnoremap <space> za
vnoremap <space> zf

" Quickly edit/reload the vimrc file
nnoremap <leader>ev <c-w><c-v><c-l>:e $MYVIMRC<cr>

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

au BufRead,BufNewFile *.slab,*.mu,*.mustache set filetype=html

" Read .ru and capfiles as ruby
au BufRead,BufNewFile *.god,*.ru set filetype=ruby
au BufRead,BufNewFile capfile set filetype=ruby
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile Vagrantfile set filetype=ruby

" hard-wrap markdown files
au BufRead,BufNewFile *.md setl wrap tw=80 sw=2 sts=2 et

" Two space indents for ruby
au FileType ruby setl sw=2 sts=2 et

" Four space indents for python
au FileType python setl sw=4 sts=4 et

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

" When editing a file, always jump to the last known cursor position.
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
