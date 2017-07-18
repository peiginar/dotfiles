set modeline
" set modeline undofile
set autoindent
set ts=2 sw=2 et nu

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'vim-jp/vimdoc-ja'
call neobundle#end()

NeoBundleCheck
if has('vim_starting')
  call neobundle#call_hook('on_source')
endif

set helplang=ja,en
syntax on

" vim: set ts=2 sw=2 et:
