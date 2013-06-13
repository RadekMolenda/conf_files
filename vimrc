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
colorscheme vividchalk
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
set cursorline
filetype plugin on
filetype indent on


nmap <silent> <Leader>v :new ~/.vimrc<cr>
nmap <Leader>sv :source ~/.vimrc<cr>
nmap ~ ,

map ,,t :w<bar>execute("!bundle exec rspec ". expand("%") . " -l ". line("."))<cr>
nmap <Leader>t :map ,t :w\<bar>!bundle exec rspec --fail-fast <C-r>% <cr
imap <C-j> <Esc>ko


autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby nmap ,st :call OpenSpec()<cr>
autocmd FileType ruby,eruby nmap ,ss :call OpenSource()<cr>
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd FileType scheme nmap ,st :call Open(Search(SchemeTestFile()))<cr>
autocmd FileType scheme nmap ,ss :call Open(Search(SchemeSourceFile()))<cr>

hi Visual ctermbg=4
hi ColorColumn ctermbg=12

highlight ExtraWhitespace ctermbg=red guibg=red

function! Open(filename)
  execute ":e" . a:filename
endfunction

function! SchemeSourceFile()
  return substitute(Basename(), '\(-test\)\|$', '.scm', '')
endfunction

function! SchemeTestFile()
  return substitute(SchemeSourceFile(), '\.scm', '-test.scm', '')
endfunction

function! Search(file)
  return Chomp(system('find . -iname "*' . a:file .'"'))
endfunction

function! OpenSourceScheme()
  echo "OpenSourceScheme"
endfunction

function! Quickfix()
  set errorformat+=%f
  cex Chomp(RailsTestFiles())
endfunction

function! Ctags()
  execute ':!ctags-exuberant --exclude=public --exclude=log --exclude=config --extra=+f -R * '
endfunction

function! OpenSpec()
  return Quickfix()
endfunction

function! OpenSource()
  execute ':vsplit ' . RailsSourceFile()
endfunction

function! Specs(root, file)
  return system('find ' . a:root . '/spec -iname "' . a:file .'_spec.rb"')
endfunction

function! Sources(root, file)
  return system('find ' . a:root . ' -iname "' . a:file .'.rb"')
endfunction

function! RootDir()
  return Chomp(system("git rev-parse --show-toplevel"))
endfunction

function! Chomp(string)
  return substitute(a:string, '\n$', '', '')
endfunction

function! Basename()
  return expand('%:t:r')
endfunction

function! Sourcename()
  return substitute(Basename(), '_spec', '', '')
endfunction

function! RailsTestFiles()
  return Specs(RootDir(), Basename())
endfunction

function! RailsSourceFile()
  return Sources(RootDir(), Sourcename())
endfunction
