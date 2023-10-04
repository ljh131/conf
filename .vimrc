"
" basic settings
"
if has('gui_running')
  set guifont=Monaco:h16
  let macvim_skip_colorscheme=1
else
  set t_Co=256
endif

set ttyfast
set lazyredraw

set nocompatible
set cindent
set smartindent
set autoindent
"set nowrap
set ff=unix
set bg=dark

syntax on
let &tenc=&enc
set encoding=utf-8
set fileencodings=utf-8
set fileencoding=utf-8
set ruler
set showcmd
set showmatch
set title

set completeopt-=preview

set nu
set hlsearch
set ignorecase
set noincsearch " explicit for nvim
set ru
set ic

set scs
"set ls=2

set noshowmode
set wildignore+=*.so,*.swp,*.zip,*.o,*.gz,*/node_modules/*
set tags=tags,./tags,../tags,/usr/include/tags,/usr/local/include/tags

set ts=2
set sw=2
set sts=2
set expandtab

set backspace=indent,eol,start


colorscheme default

" use diffrent color for vimdiff
if &diff
  hi DiffAdd         ctermbg=black       ctermfg=green       cterm=reverse
  hi DiffChange      ctermbg=black       ctermfg=magenta     cterm=reverse
  hi DiffDelete      ctermbg=black       ctermfg=darkred     cterm=reverse
  hi DiffText        ctermbg=black       ctermfg=red         cterm=reverse
endif


"
" key mappings
"
inoremap jj <Esc>

"map <F5> :!rvm 2.2.4 do starscope; rvm 2.2.4 do starscope -e ctags; rvm 2.2.4 do starscope -e cscope<cr>:csc reset<cr>
map <F5> :!find . -name '*.c' -o -name '*.cpp' -o -name '*.cc' -o -name '*.h' > cscope.files; cscope -R -b; ctags -R<cr>
map <F6> :cw<cr>
map <F7> :tabp<cr>
map <F8> :tabn<cr>
map <F9> :tab sp<cr>
map <F10> :vimgrep /TODO\\|FIXME\\|XXX/ %:p:h/*<cr>:cw<cr>
map <F12> :TlistToggle<cr>

map ,q :q<CR>
map ,w :w<CR>

map <C-n> gt
map <C-m> gT

" settings from http://amix.dk/vim/vimrc.html
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


"
" Vundle
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'The-NERD-tree'
Plugin 'taglist.vim'
Plugin 'ctrlp.vim'
Plugin 'MattesGroeger/vim-bookmarks' " warn: it's too buggy!!!
Plugin 'itchyny/lightline.vim'
Plugin 'mileszs/ack.vim'

" language specific
"Plugin 'pangloss/vim-javascript' 
"Plugin 'mxw/vim-jsx' 


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"
" plugins setting
"

""" Taglist
let Tlist_Use_Right_Window   = 1


""" NERDTree
let NERDTreeWinPos = "left"
nmap <F11> :NERDTreeToggle<CR>


""" ctrlp
let g:ctrlp_working_path_mode = 'c'
" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_lazy_update = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|public$\|log$\|tmp$\|vendor$',
  \ 'file': '\v\.(exe|so|dll)$'
\ }


""" bookmark
highlight BookmarkSign ctermbg=blue ctermfg=NONE
highlight BookmarkLine ctermbg=blue ctermfg=NONE
let g:bookmark_sign = '⚑'
let g:bookmark_highlight_lines = 1
let g:bookmark_auto_save = 0


""" lightline
set laststatus=2 " turn on bottom bar
set noshowmode

" Replace filename component of Lightline statusline
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'readonly', 'filename' ] ],
\ },
\ 'component_function': {
\   'filename': 'LightlineFilename',
\   'fileformat': 'LightlineFileformat',
\   'filetype': 'LightlineFiletype',
\ },
\ }

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFilename()
  "let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  " Show full path of filename
  let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction


"
" others
"
if has("autocmd")
  " When editing a file, always jump to the last cursor position
   autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal g'\"" |
    \ endif
endif

" fix vundle bug (correct tabstop for python)
autocmd Filetype python setlocal expandtab ts=2 sw=2 sts=2

