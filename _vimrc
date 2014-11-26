" towry's vimfiles

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction



" towry's vimfiles

" Some lets
let s:is_mac = has('macunix')
let s:is_gui_macvim = has('gui_macvim')
let s:is_windows = has('win32') || has('win64')
let s:is_gui_windows = has('gui_win32') || has('gui_win64')
let $DOTVIM = 'D:/devkits/VimPortable/App/vim'
let $TMPDIR = expand('./tmp')
" please create tmp direcotry manually

if s:is_windows
 set shellslash
endif

syntax enable
set history=700
set autoread

let mapleader = ','
let g:mapleader = ','

set backspace=indent,eol,start  " remove indent, eol and start by <BS>
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab  " convert a tab to 4 spaces

" set cindent
set cino=g0
set autoindent
set smartindent
set number
set title
set ruler  " cursor pos
set wrap
set autochdir
set modeline
set showmatch
set matchtime=2
set laststatus=2
" set cmdheight=2
" set list
set display=lastline
set splitright
set textwidth=0
" set helplang=en
" set mousehide
set hlsearch
set novisualbell
set noerrorbells
" set shortmess=aiI  // hide the tip on start ?
" set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
set nobackup
set noswapfile
" set directory=$TMPDIR
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
if has('gui_running')
 set cursorline " highlight the curr line
endif
" set gcr=a:blinkon0 " do not blink | this will cause a warning: https://groups.google.com/forum/#!topic/vim_dev/Pmxb8swH1yE

set wildmenu
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif
set wildmode=list:full

set ttyfast

set colorcolumn=+0
set scrolloff=3

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>nh :nohl<CR>
inoremap <leader><leader> <esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle manager
set nocompatible
filetype off

set rtp+=$DOTVIM/bundle/Vundle.vim
call vundle#begin()
call vundle#rc(expand('$DOTVIM/bundle'))

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'plasticboy/vim-markdown'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/html5.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'sorin-ionescu/python.vim'
Plugin 'jnwhiteh/vim-golang'
Plugin 'hail2u/vim-css3-syntax'

call vundle#end()
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:colors_name') && !has('gui_running')
 " use 256 colors in terminal
 set t_Co=256
elseif has('gui_running')
 set background=dark
 colorscheme desert
 set guioptions-=T
" set guioptions-=m

 if s:is_gui_windows
  set lines=30 columns=83
  set guifont=Consolas:h11:cANSI
 elseif s:is_gui_macvim
  set lines=34 columns=93
  set guifont=Inconsolata:h11
 else
  set lines=34 columns=84
  set guifont=Inconsolata\ 12
 endif
endif

set fileformat=unix
if s:is_windows
 set fileformats=dos,unix,mac
else
 set fileformats=unix,dos,mac
endif

function! s:set_two_indent()
 setlocal shiftwidth=2 softtabstop=2 expandtab
endfunction
function! s:set_four_indent()
 setlocal shiftwidth=4 softtabstop=4 expandtab
endfunction

function! DeleteTrailingWS()
 exe "normal mz"
 %s/\s\+$//ge
 exe "normal `z"
endfunction

function! HasPaste()
 if &paste
  return 'PASTE MODE'
 en
 return ''
endfunction


augroup MyTab
 autocmd!
 " autocmd FileType ruby call s:set_two_indent()
 autocmd FileType vim call s:set_two_indent()
 autocmd FileType javascript call s:set_two_indent()
 autocmd FileType html call s:set_two_indent()
 autocmd FileType xhtml call s:set_two_indent()
 autocmd FileType haml call s:set_two_indent()
 autocmd FileType css call s:set_two_indent()
 autocmd FileType scss call s:set_two_indent()
 autocmd FileType c call s:set_two_indent()
augroup END

augroup VimCSS3Syntax
 autocmd!
 autocmd FileType css,scss,less setlocal iskeyword+=-
augroup END

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
