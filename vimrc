" vim-sublime - A minimal Sublime Text -like vim experience bundle
"               http://github.com/grigio/vim-sublime

" NB: You need a terminal with 256 colors support

set nocompatible              " be iMproved
set fo=tcq
set modeline
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
" Plugins
Plugin 'L9'
Plugin 'tpope/vim-surround'
Plugin 'tomtom/tcomment_vim'
Plugin 'gcmt/breeze.vim'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'puppetlabs/puppet-syntax-vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on

set ruler
au BufRead,BufNewFile *.pp
  \ set filetype=puppet
au BufRead,BufNewFile *_spec.rb
  \ nmap <F8> :!rspec --color %<CR>
au BufRead,BufNewFile *.ps1 set syntax=ps1

let &colorcolumn=join(range(81,999),",")

set background=dark
set textwidth=80
set paste
syntax on

set noerrorbells                " No beeps
set number                      " Show line numbers
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.

set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically reread changed files without asking me anything

set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats

set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters

set switchbuf=usetab,newtab     " open new buffers always in new tabs

set smartindent
set tabstop=4 shiftwidth=4
set expandtab
set listchars=tab:▒░,trail:▓
set list

set cursorline

autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

" open nerdtree when no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

filetype plugin indent on

" Find
map <C-f> /
" indend / deindent after selecting the text with (⇧ v), (.) to repeat.
vmap <Tab> >
vmap <S-Tab> <
" comment / decomment & normal comment behavior
vmap <C-m> gc
" Disable tComment to escape some entities
let g:tcomment#replacements_xml={}
" Text wrap simpler, then type the open tag or ',"
vmap <C-w> S
" " Tabs
let g:airline_theme='murmur'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2
nnoremap <C-b>  :tabprevious<CR>
inoremap <C-b>  <Esc>:tabprevious<CR>i
nnoremap <C-n>  :tabnext<CR>
inoremap <C-n>  <Esc>:tabnext<CR>i
nnoremap <C-t>  :tabnew<CR>
inoremap <C-t>  <Esc>:tabnew<CR>i
nnoremap <C-k>  :tabclose<CR>
inoremap <C-k>  <Esc>:tabclose<CR>i

if isdirectory(expand("$HOME/.vim/"))
  source $HOME/.vim/packages.vim
  source $HOME/.vim/shortcuts.vim
endif

" automatically chmod+x files that begin with #!/bin*
augroup Executable
au BufWritePost * call MakeExecutable()
augroup END

au BufRead,BufNewFile *.scala
  \ set filetype=scala noexpandtab

function! MakeExecutable()
  if getline(1)=~"^#!.*/bin/"
    silent !chmod a+x <afile>
  endif
endfunction
