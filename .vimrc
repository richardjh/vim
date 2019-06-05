" .vimrc - Richard Holloway <richard@richardjh.org>
"
" F1  - Help
" F2  - Open/Focus NERDTree
" F3  - Open/Focus NERDTree at current file
" F4  - Search on php.net for under cursor
" F5  - Run current test
" F6  - Next pane
" F7  - Previous buffer
" F8  - Next buffer
" F9  -
" F10 - Refresh ctags
" F11 - Desktop fullscreen window
" F12 - Toggle Tag list

" Options
set nocompatible
set t_Co=256

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/vim-nerdtree_plugin_open'
Plugin 'scrooloose/syntastic'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'dietsche/vim-lastplace'
Plugin 'morhetz/gruvbox'
Plugin 'ap/vim-css-color'
Plugin 'luochen1990/rainbow'
Plugin 'lepture/vim-jinja'
Plugin 'majutsushi/tagbar'
call vundle#end()
filetype plugin indent on

" Appearance
set novisualbell
set showmode
set number
set showmatch
set spell spelllang=en_gb
set scrolloff=6
set hlsearch
syntax on
set listchars=tab:▸\ ,trail:·,nbsp:·
set list

" Turn on rainbow matching
let g:rainbow_active = 1

" Colour
colorscheme gruvbox
set background=dark
hi clear SpellBad
hi SpellBad cterm=underline

" Strip trailing white space on save
autocmd BufWritePre * :%s/\s\+$//e

" Indentation guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black    ctermbg=black
autocmd VimEnter,ColorschemE * :hi IndentGuidesEven guibg=darkgrey ctermbg=darkgrey

" Temp files
set nobackup
set nowritebackup
set noswapfile

" Exuberant tags
set tags=tags
nmap <F10> :!ctags -R --fields=+aimS --languages=php <CR>

" Code completion
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
set completeopt=longest,menuone
let g:neocomplete#enable_at_startup = 1

" Indenting
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set expandtab
set autoindent
set copyindent
set nowrap
set nojoinspaces

" Searching
set ignorecase
set smartcase

" NERDTree
nmap <C-v> :vertical resize +5<cr>
nmap <F2> :NERDTree<cr>
nmap <F3> :NERDTreeFind<cr>

" NERDTree open (use E to open a file in default application)
let g:nerdtree_plugin_open_cmd = 'xdg-open'

" CtrlP
let g:ctrlp_working_path_mode = 'rw'

" vim-airline
set laststatus=2
let g:airline#extensions#tabline#enabled=1
let g:airline_detect_paste=0
let g:airline_theme='jellybeans'

" tagbar
set ut=100 "update the taglist faster (was about 4 seconds)
let g:tagbar_show_visibility = 1
let g:tagbar_width = 25
nmap <F12> :TagbarToggle<CR><CR>

" buffers
set hidden
nmap <F7> :bp<cr>
nmap <F8> :bn<cr>
"Disable NERDTree buffer switching
autocmd FileType nerdtree noremap <buffer> <F7> <nop>
autocmd FileType nerdtree noremap <buffer> <F8> <nop>

" Change filetype associations
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.twig set filetype=html
au BufRead,BufNewFile *.latte set filetype=html
au BufRead,BufNewFile *.html set filetype=html

" PHP Manual lookup
function! BrowseDoc()
  ! xdg-open "http://php.net/manual-lookup.php?pattern=<cword>" 1>/dev/null 2>/dev/null &
endfunction
map <F4> :call BrowseDoc()<cr><cr>

" Run current test
nmap <F5> :!phpunit "%" --stderr<CR>

" Run current file as php script
nmap <F6> <C-w><C-w>

" Syntastic, requires php, phpstan, phpcs and phpmd in your path
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_php_phpcs_args = 'standard=PSR2'
let g:syntastic_php_checkers = ['php', 'phpstan', 'phpcs', 'phpmd']
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_html_tidy_ignore_errors = ['escaping malformed URI reference', 'trimming empty', "plain text isn't allowed in"]

" Silver Searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" Mouse
set mouse=
set mousehide

" Save as root
cmap w!! %!sudo /usr/bin/tee > /dev/null %

" Let % match html tags too
runtime macros/matchit.vim

" Calculator
" usage: type in insert mode 8*6 and press <C-a> and 8*6 is replaced
"        by 8*6=48
ino <C-a> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" Date
nmap <C-d> :r!date +'\%Y-\%m-\%d \%H:\%M:\%S '<CR>
