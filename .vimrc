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

"nnoremap ff :marks<cr>
"nnoremap fc :delmarks a-z0-9<cr>
set completeopt-=preview

set nu
set hlsearch
set ignorecase
"set incsearch
set ru
set noic

set scs
"set ls=2

set noshowmode
set wildignore+=*.so,*.swp,*.zip,*.o,*.gz     " Linux/MacOSX
set tags=tags,./tags,../tags,/usr/include/tags,/usr/local/include/tags

""" tab
set ts=2
set sw=2
set sts=2
set expandtab

"make vim save and load the folding of the document each time it loads"
""also places the cursor in the last place that it was left."
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview


""" key mapping
map <F5> :!rvm 2.2.4 do starscope; rvm 2.2.4 do starscope -e ctags; rvm 2.2.4 do starscope -e cscope<cr>:csc reset<cr>
map <F6> :cw<cr>

map <F7> :tabp<cr>
map <F8> :tabn<cr>
map <F9> :tab sp<cr>

map <F10> :vimgrep /TODO\\|FIXME\\|XXX/ %:p:h/*<cr>:cw<cr>

""" shortcuts
map ,q :q<CR>
map ,w :w<CR>

map <C-n> :tabn<cr>
map <C-m> :tabp<cr>

""" settings from http://amix.dk/vim/vimrc.html
""" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

if has("autocmd")
	  " When editing a file, always jump to the last cursor position
	   autocmd BufReadPost *
	    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
	    \   exe "normal g'\"" |
	    \ endif
  endif


""" Vundle
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
Plugin 'neocomplcache'
Plugin 'ctrlp.vim'

" it's too buggy!!!
Plugin 'MattesGroeger/vim-bookmarks'

" language specific
"Plugin 'slim-template/vim-slim.git'
Plugin 'pangloss/vim-javascript' 
Plugin 'mxw/vim-jsx' 
Plugin 'kchmck/vim-coffee-script'
Plugin 'andreshazard/vim-freemarker'


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


""" neocomplcache
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


""" bookmark
highlight BookmarkSign ctermbg=blue ctermfg=NONE
highlight BookmarkLine ctermbg=blue ctermfg=NONE
let g:bookmark_sign = '⚑'
let g:bookmark_highlight_lines = 1
let g:bookmark_auto_save = 0


""" fix vundle bug (correct tabstop for python)
autocmd Filetype python setlocal expandtab ts=2 sw=2 sts=2
