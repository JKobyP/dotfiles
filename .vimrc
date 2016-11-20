"*** These settings are my frankenstein
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set laststatus=2   " Always show the statusline
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors

" keeps lines from getting too long
set textwidth=80
" maps whitespace to visible stuff
set encoding=utf-8
set listchars=tab:→\ ,trail:·

" forces vim to load vimrc in working directory if exists (for project specific configs)
set exrc
set secure 

" style guide
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" Highlights column 80 so i know if my lines are too long
set colorcolumn=80
highlight ColorColumn ctermbg=magenta
autocmd Filetype go set colorcolumn=0

"*** Pathogen
"execute pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep a backup file (restore to previous version)
set undofile		" keep an undo file (undo changes after closing)
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  highlight incsearch ctermbg=23
  highlight search ctermbg=23
endif

"{{{ Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrc
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif

  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd") }}}

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"*** From Arch wiki
set wrapscan " Search wrapsaround end of file
:set number
autocmd InsertEnter * :set norelativenumber
autocmd InsertEnter * :set list
autocmd InsertLeave * :set relativenumber
autocmd InsertLeave * :set nolist 

noremap <C-m> <C-W>
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
let mapleader=","

" plugins
"noremap <Leader>e :NERDTreeToggle <CR>
"set runtimepath^=~/.vim/bundle/ctrlp.vim

" separate backup folders
"set backup
"set backupdir=~/.vim/backup
"set directory=~/.vim/tmp

"automatically change to the directory of the file in the buffer
set autochdir

set foldmethod=marker
inoremap jj <Esc>
