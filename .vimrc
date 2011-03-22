set fileencoding=japan
set fileencodings=utf-8,iso-2022-jp,utf-8,euc-jp,ucs-2le,ucs-2,cp932
set number
set showmode

set nocompatible
syntax on
filetype on
filetype indent on
filetype plugin on

setlocal omnifunc=syntaxcomplete#Complete

let g:quickrun_config = {}
let g:quickrun_config['ruby.rspec'] = {'command': 'spec'}

augroup UjihisaRSpec
	  autocmd!
	    autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

set t_kb=

