set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,utf-8,euc-jp,ucs-2le,ucs-2,cp932
set number
set showmode
set laststatus=2
set statusline=%t[%{&fenc!=''?&fenc:&enc}][%{&ff}]

setlocal omnifunc=syntaxcomplete#Complete
set nocompatible
syntax on
filetype on
filetype indent on
filetype plugin on


let g:quickrun_config = {}
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec', "exec": "%c -l {line('.')}  %s"}



augroup UjihisaRSpec
	  autocmd!
	    autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

set t_kb=
autocmd BufNewFile *_spec.rb 0r $HOME/.vim/template/rspec
autocmd BufNewFile *[^_spec].rb 0r $HOME/.vim/template/ruby
