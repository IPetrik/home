set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'mhordecki/vim-subword'
"Plugin 'valloric/youcompleteme'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set t_Co=16

if $TERM == "xterm-256color"
  set t_Co=256

  "let g:solarized_bold = 0
  "let g:solarized_contrast = "low"
  "let g:solarized_termcolors = 256
endif

set laststatus=2

""""""""""""""""""""""
" Conf for airline   "
""""""""""""""""""""""
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#buffer_nr_show = 1
call airline#parts#define_accent('linenr', 'none')

syntax enable
set background=dark
colorscheme solarized

set wrap
set linebreak
let &showbreak = ' `-> '

set number
set numberwidth=4

set mouse=n
set scrolloff=10

set tabstop=2
set shiftwidth=2
set expandtab

set pastetoggle=<F3> 

nmap <C-j> o<Esc>
nmap <C-k> O<Esc><C-e>
nmap <S-k> kJ 
nmap <C-h> i<Space><Esc>

highlight OverLength ctermbg=000 
match OverLength /\(\%81v.\+\|\s\+$\)/
"highlight TrailingWS ctermbg=003
"match TrailingWS /\s\+$/
"set foldmethod=syntax
"let perl_fold=1

filetype plugin indent on
autocmd FileType perl setlocal equalprg=perltidy\ -st\ -l=300\ -i=2\ -pt=2

runtime autoload/ShowLine.vim
runtime autoload/ShowBlockName.vim

au CursorHold * call ShowBlockName('quiet')

" Show the name of the function we're in on the message line; pnuemonic [[
map <silent> g[[ :call ShowBlockName()<CR>

" Disable ShowBlockName (once); to prevent the CursorHold autocommand from
" overwriting something in the command window (e.g., SyntaxAttr() output).
map <silent> g]] :call ShowBlockName('OFF')<CR>


" Tweak commands like [d so that they disable ShowBlockName so
" it doesn't obliterate the output of this command.
nnoremap [d :call ShowBlockName('[d')<CR>
nnoremap [i :call ShowBlockName('[i')<CR> 

augroup gzip
 autocmd!
 autocmd BufReadPre,FileReadPre *.gz set bin
 autocmd BufReadPost,FileReadPost   *.gz '[,']!gunzip
 autocmd BufReadPost,FileReadPost   *.gz set nobin
 autocmd BufReadPost,FileReadPost   *.gz execute ":doautocmd BufReadPost " . expand("%:r")
 autocmd BufWritePost,FileWritePost *.gz !mv <afile> <afile>:r
 autocmd BufWritePost,FileWritePost *.gz !gzip <afile>:r
 autocmd FileAppendPre      *.gz !gunzip <afile>
 autocmd FileAppendPre      *.gz !mv <afile>:r <afile>
 autocmd FileAppendPost     *.gz !mv <afile> <afile>:r
 autocmd FileAppendPost     *.gz !gzip <afile>:r
augroup END

autocmd FileType python setlocal tabstop=4 shiftwidth=4
