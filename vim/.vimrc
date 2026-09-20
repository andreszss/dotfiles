if v:progname =~? "evim"
  finish
endif

if exists('skip_defaults_vim')
  finish
endif

if &compatible
  set nocompatible
endif

silent! while 0
  set nocompatible
silent! endwhile

set ttimeout		
set ttimeoutlen=100	

set display=truncate

set scrolloff=5

if has('reltime')
  set incsearch
endif

set nrformats-=octal

if has('win32')
  set guioptions-=t
endif

map Q gq
sunmap Q

inoremap <C-U> <C-G>u<C-U>

if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

if 1
  filetype plugin indent on

  augroup vimStartup
    autocmd!

    autocmd BufReadPost *
      \ let line = line("'\"")
      \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
      \      && index(['xxd', 'gitrebase', 'tutor'], &filetype) == -1
      \      && !&diff
      \ |   execute "normal! g`\""
      \ | endif

    autocmd TermResponse * if v:termresponse == "\e[>0;136;0c" | set bg=dark | endif
  augroup END

  augroup vimHints
    au!
    autocmd CmdwinEnter *
	  \ echohl Todo |
	  \ echo gettext('You discovered the command-line window! You can close it with ":q".') |
	  \ echohl None
  augroup END

endif

if &t_Co > 2 || has("gui_running")
  syntax on
  let c_comment_strings=1
endif

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  set nolangremap
endif

set mouse=
set number
set tabstop=4
set shiftwidth=4
