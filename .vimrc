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



set t_kb=
autocmd BufNewFile *_spec.rb 0r $HOME/.vim/template/rspec
autocmd BufNewFile *[^_spec].rb 0r $HOME/.vim/template/ruby

let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = "/Users/azusa/bin/ng"

"vundle
set nocompatible
filetype off                   " (1)

set rtp+=~/.vim/vundle.git/    " (2)
call vundle#rc()               " (3)
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-ref'
Bundle 'Shougo/neocomplcache'

filetype plugin indent on     " (5)

let g:quickrun_config = {}
let g:quickrun_config['php'] = {'command': 'phpunit'}

augroup QrunRSpec
	autocmd!
	autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END 

let rspec_outputter = quickrun#outputter#buffer#new()
function! rspec_outputter.init(session)
	call call(quickrun#outputter#buffer#new().init,  [a:session],  self)
endfunction

function! rspec_outputter.finish(session)
	highlight default RSpecGreen ctermfg = Green cterm = none
	highlight default RSpecRed    ctermfg = Red   cterm = none
	highlight default RSpecComment ctermfg = Cyan  cterm = none
	highlight default RSpecNormal  ctermfg = White cterm = none
	call matchadd("RSpecGreen", "^[\.F]*\.[\.F]*$")
	call matchadd("RSpecGreen", "^.*, 0 failures$")
	call matchadd("RSpecRed", "F")
	call matchadd("RSpecRed", "^.*, [1-9]* failures.*$")
	call matchadd("RSpecRed", "^.*, 1 failure.*$")
	call matchadd("RSpecRed", "^ *(.*$")
	call matchadd("RSpecRed", "^ *expected.*$")
	call matchadd("RSpecRed", "^ *got.*$")
	call matchadd("RSpecRed", "^ *Failure/Error:.*$")
	call matchadd("RSpecRed", "^.*(FAILED - [0-9]*)$")
	call matchadd("RSpecRed", "^rspec .*:.*$")
	call matchadd("RSpecComment", " # .*$")
	call matchadd("RSpecNormal", "^Failures:")
	call matchadd("RSpecNormal", "^Finished")
	call matchadd("RSpecNormal", "^Failed")

	call call(quickrun#outputter#buffer#new().finish,  [a:session], self)
endfunction

call quickrun#register_outputter("rspec_outputter", rspec_outputter)
let g:quickrun_config['ruby.rspec'] = { 
			\ 'command': 'rspec',
			\ 'outputter': 'rspec_outputter',
			\ }

augroup UjihisaRSpec
	autocmd!
	autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END
let g:rubycomplete_buffer_loading = 1



	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplcache.
	let g:neocomplcache_enable_at_startup = 1
	" Use smartcase.
	let g:neocomplcache_enable_smart_case = 1
	" Use camel case completion.
	let g:neocomplcache_enable_camel_case_completion = 1
	" Use underbar completion.
	let g:neocomplcache_enable_underbar_completion = 1
	" Set minimum syntax keyword length.
	let g:neocomplcache_min_syntax_length = 3
	let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
	
	" Define dictionary.
	let g:neocomplcache_dictionary_filetype_lists = {
	    \ 'default' : '',
	    \ 'vimshell' : $HOME.'/.vimshell_hist',
	    \ 'scheme' : $HOME.'/.gosh_completions'
	        \ }
	
	" Define keyword.
	if !exists('g:neocomplcache_keyword_patterns')
	    let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
	
	" Plugin key-mappings.
	imap <C-k>     <Plug>(neocomplcache_snippets_expand)
	smap <C-k>     <Plug>(neocomplcache_snippets_expand)
	inoremap <expr><C-g>     neocomplcache#undo_completion()
	inoremap <expr><C-l>     neocomplcache#complete_common_string()
	
	" SuperTab like snippets behavior.
	"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
	
	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplcache#close_popup()
	inoremap <expr><C-e>  neocomplcache#cancel_popup()
	
	" For cursor moving in insert mode(Not recommended)
	inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
	inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
	inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
	inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
	
	" AutoComplPop like behavior.
	"let g:neocomplcache_enable_auto_select = 1
	
	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplcache_enable_auto_select = 1
	"let g:neocomplcache_disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
	"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
	
	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	
	" Enable heavy omni completion.
	if !exists('g:neocomplcache_omni_patterns')
		let g:neocomplcache_omni_patterns = {}
	endif
	let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
	"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
	let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
	let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

	
set clipboard=unnamed,autoselect
