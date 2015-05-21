" .vimrc - Richard Holloway <richard@richardjh.org>
"
" F1  - Help
" F2  - Open/Focus NERDTree
" F3  - Open/Focus NERDTree at current file
" F4  - Search on php.net for under cursor
" F5  - Starts VDebug (default key)
" F6  - Refresh tags list
" F7  - Previous buffer
" F8  - Next buffer
" F9  - Syntastic check, Shift+F9 - reset, Ctrl+F9 - list, Ctrl+Shift+F9 - close errors
" F10 - Set breakpoint
" F11 - Desktop fullscreen window
" F12 - Toggle Tag list

" Options
set nocompatible
set t_Co=256

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'austintaylor/vim-commaobject'
Plugin 'beberlei/vim-php-refactor'
Plugin 'bling/vim-airline'
Plugin 'gmarik/Vundle.vim'
Plugin 'joonty/vdebug.git'
Plugin 'kien/ctrlp.vim'
Plugin 'msanders/snipmate.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/xoria256.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'Shougo/neocomplete.vim'
Plugin 'morhetz/gruvbox'
call vundle#end()
filetype plugin indent on

" Appearance
set showmode
set number
set showmatch
set spell spelllang=en_gb
set cursorline
set scrolloff=3
set foldmethod=indent
set foldlevel=99
set fillchars="fold: " 
set hlsearch
syntax on

" GUI Appearance
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=m  "remove menu
set guioptions-=T  "remove toolbar
if has("gui_running")
  set lines=40 columns=160 " make the window a little bigger
endif

" Colour
colorscheme xoria256
"colorscheme gruvbox
"set background=dark

" Long lines
highlight ColorColumn ctermbg=0 guibg=DarkGrey
set colorcolumn=80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/

" Indentation guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black    ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=darkgrey

" Temp files
set nobackup
set nowritebackup
set noswapfile

" Exuberant tags
set tags=tags
nmap <F6> :!ctags -R --fields=+aimS --languages=php <CR>

" Tag list
let Tlist_Use_Right_Window   = 1
nmap <F12> :TlistToggle<cr>

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

" Snip mate
set nopaste

" NERDTree
nmap <C-v> :vertical resize +5<cr>
nmap <C-b> :NERDTreeToggle<cr>
nmap <F2> :NERDTree<cr>
nmap <F3> :NERDTreeFind<cr>

" CtrlP
let g:ctrlp_working_path_mode = 'rw'

" VimWiki
let g:vimwiki_list = [ {'path':'~/.vimwiki', 'path_html':'~/.vimwiki/html'} ]

" Restore cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" vim-airline
set laststatus=2
let g:airline#extensions#tabline#enabled=1
let g:airline_detect_paste=0
let g:airline_theme='jellybeans'

" buffers
set hidden
nmap <F7> :bp<cr>
nmap <F8> :bn<cr>
"Disable NERDTree buffer switching
autocmd FileType nerdtree noremap <buffer> <F7> <nop>
autocmd FileType nerdtree noremap <buffer> <F8> <nop>

" Change filetype associations
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.blade.php set filetype=html
au BufRead,BufNewFile *.twig set filetype=html

" PHP Manual lookup
function! BrowseDoc()
  ! xdg-open "http://php.net/manual-lookup.php?pattern=<cword>" 1>/dev/null 2>/dev/null &
endfunction
map <F4> :call BrowseDoc()<cr><cr>

" Syntastic, requires phpcs and phpmd in your path
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
nmap <F9> :SyntasticCheck<cr>
nmap <S-F9> :SyntasticReset<cr>
nmap <C-F9> :Errors<cr>
nmap <S-C-F9> :lclose<cr>

" Silver Searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" Comment out to break bad habits
set mouse=a
set mousehide
" Uncomment to break bad habits
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>
"noremap <Home> <NOP>
"noremap <End> <NOP>
"noremap <BS> <NOP>
"noremap <Insert> <NOP>
"noremap <Del> <NOP>

" Map CapsLock to Esc
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

" Printing
set printoptions=number:y,syntax:n
"set printheader=%<%f\ [%{strftime('%d/%m/%y')}]%=\ %N/%{line('$')/73+1}
set printheader=%<%f%=\ %N/%{line('$')/73+1}

" Clipboard
set clipboard=unnamedplus
