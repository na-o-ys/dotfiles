" Shell
set shell=bash

"""""""""""""""
" NeoBundle
"""""""""""""""
if has ('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Goods
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'kana/vim-submode'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'

" Color schemes
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/newspaper.vim'
NeoBundle 'altercation/vim-colors-solarized'

" For specific languages/frameworks
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'soh335/vim-symfony'
NeoBundle 'aharisu/vim_goshrepl'
NeoBundle 'kana/vim-filetype-haskell'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'dag/vim-fish'
NeoBundle 'fatih/vim-go'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"""""""""""""""
" General preferences
"""""""""""""""
" Color
:set t_Co=256
syntax enable
colorscheme hybrid

" Indentation
set shiftwidth=2
set autoindent
set expandtab

" Line number
set number

" Swap colon for us keyboard
noremap : ;
noremap ; :

" Cursor moving on insert mode
inoremap <C-l> <Right>
inoremap <C-h> <Left>

" Keymap for Buffer
nnoremap <silent> <C-n>  :bnext<CR>
nnoremap <silent> <C-p>  :bprevious<CR>

" Keymap for resizing window
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')

" Keymap for Ctags
nnoremap t    <Nop>
nnoremap tt  <C-]>
nnoremap tj  :<C-u>tag<CR>
nnoremap tk  :<C-u>pop<CR>
nnoremap tl  :<C-u>tags<CR>

" Neocomplcache
let g:neocomplcache_enable_at_startup = 1
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif

" NeoSnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Hacks
vnoremap * "zy:let @/ = @z<CR>n"

"""""""""""""""
" For specific languages/frameworks
"""""""""""""""

" C++11
if executable("g++-6")
  let g:syntastic_cpp_compiler = 'g++-6'
  let g:syntastic_cpp_compiler_options = '-std=c++14'
  let g:quickrun_config = {}
  let g:quickrun_config['cpp/g++14'] = {
      \ 'cmdopt': '-std=c++14',
      \ 'type': 'cpp/g++'
    \ }
  let g:quickrun_config['cpp'] = {'type': 'cpp/g++14'}
elseif executable("clang++")
  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = '-std=c++1y'
  let g:quickrun_config = {}
  let g:quickrun_config['cpp/clang++1y'] = {
      \ 'cmdopt': '-std=c++1y',
      \ 'type': 'cpp/clang++'
    \ }
  let g:quickrun_config['cpp'] = {'type': 'cpp/clang++1y'}
endif
autocmd FileType cpp setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

" GoLang
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
au BufNewFile,BufRead *.go setf go
autocmd FileType go setl tabstop=8 shiftwidth=8 softtabstop=8

" PHP
autocmd FileType php setl autoindent
autocmd FileType php setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType php setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
let g:syntastic_quiet_messages = { "type": "style", "file": '\m\c\.php$'}

" Python
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

" Gauche
let g:neocomplcache_keyword_patterns['gosh-repl'] = "[[:alpha:]+*/@$_=.!?-][[:alnum:]+*/@$_:=.!?-]*"
autocmd FileType scheme vmap <CR> <Plug>(gosh_repl_send_block)

" Haskell
autocmd FileType haskell setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

"""""""""""""""
" Unite.vim
"""""""""""""""
" Ag
if executable('ag')
  try
    let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
    call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', 'vendor\/bundle')
  catch
  endtry
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

noremap  [unite] <Nop>
map      <Space> [unite]
nnoremap <silent>[unite]b :<C-u>Unite -immediately -no-empty buffer<CR>
nnoremap <silent>[unite]e :<C-u>Unite file_rec/async:!<CR>
nnoremap <silent>[unite]s :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent>[unite]ws :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

let g:unite_source_history_yank_enable = 1
nnoremap <silent>[unite]y :<C-u>Unite history/yank<CR>

"""""""""""""""
" VimFiler
"""""""""""""""
nnoremap <silent>[unite]<Space> :VimFiler -split -simple -winwidth=35 -no-quit<CR>
let g:vimfiler_as_default_explorer=1
let g:vimfiler_force_overwrite_statusline=0
