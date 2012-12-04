call pathogen#infect()
set nocompatible
set path=.,./*,./**
set nobackup
set backspace=indent,eol,start
set viminfo='20,\"50"
set history=1000
set ruler
set showcmd
set incsearch
set browsedir=buffer
set pastetoggle=<F11>
set number
setlocal number
set wildmenu
set showmatch
set so=5
set laststatus=2
set fo=tcrqn
set hidden
set tags+=./stl_tags
set foldminlines=3
set wildmode=longest:full
colorscheme grb256
set foldcolumn=2
set guioptions=abegimrLtT
set nowrap
set ts=2
set st=2
set sw=2
set expandtab
set statusline=%y[%{&ff}]%{fugitive#statusline()}\ \ ASCII=\%03.3b,HEX=\%02.2B\ \ %m%r%h%w\ %1*%F%*\ %l:%v\ (%p%%)
set spelllang=en
set nospell
set cc=80
set hlsearch
filetype plugin on
filetype indent on

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

nmap <silent> <Leader>v :new ~/.vimrc<cr>
nmap <Leader>sv :source ~/.vimrc<cr>
nmap ~ ,

nmap <Leader>t :map ,t :w\<bar>!bundle exec rspec --fail-fast <C-r>%<cr
nmap ,st :call OpenSpec()<cr>
nmap ,ss :call OpenSource()<cr>
imap <C-j> <Esc>ko
"cmap <C-k> <Up>
"cmap <C-l> <Down>
"nnoremap <cr> :nohlsearch<cr>

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

function! OpenSpec()
  let filePath = expand('%')
  if StartsWith(filePath, "^app/")
    let filePath=substitute(filePath, '^app/', '', '')
  endif
  let specFilePath="spec/". substitute(filePath, '.rb', '_spec.rb', '')
  execute ':rightbelow vsplit ' . specFilePath
endfunction

function! StartsWith(expression, pattern)
  return (match(a:expression, a:pattern) != -1)
endfunction

function! Ctags()
  execute ':!ctags --exclude=public --exclude=_html --exclude=tmp --exclude=log --exclude=coverage --extra=+f -R *'
endfunction

function! OpenSource()
  let filePath=substitute(expand('%'), 'spec/', '', '')
  let filePath=substitute(filePath, '_spec.rb$', '.rb', '')
  execute ':vsplit ' . filePath
endfunction
