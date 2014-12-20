"" 基本設定 {{{
set guifont=Ricty_Diminished:h18 " フォント指定
set linespace=2
set lines=90 columns=300 " ウィンドウサイズをセット はみだした部分は自動的に修正させて画面いっぱいに表示させる
set guioptions-=T " ウィンドウ上部のタブ部分を無効に
"set noimdisableactivate
"set imdisable " IMEを無効に
set showtabline=2
set smarttab
set expandtab
"set tabstop=2
"set shiftwidth=2
set tabstop=4
set shiftwidth=4
"set smartindent
set autoindent
set showmatch
set number
set noundofile " undo ファイルを無効化
set noerrorbells " ビープ音を消す
set vb t_vb=  " ビープ音を消す
set hlsearch

au BufEnter * execute ":lcd " . expand("%:p:h")
"フルスクリーンモード
"set fuoptions=maxvert,maxhorz
"autocmd GUIEnter * set fullscreen

colorscheme hybrid " カラースキーマを指定

" encoding
set encoding=utf-8
set fileencoding=utf-8

" \を¥に置き換え
let mapleader='¥'

" コマンド、検索パターンを100個まで履歴に残す
set history=100

" 検索時、「/」の入力をエスケープ
" cnoremap  / getcmdtype() == '/' ? '\/' : '/'
"
" ブラウザでファイルを開く
:map <silent> <F5> :!open %<CR>

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END
hi clear CursorLine
" hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=Gray30

" <ESC>2回でハイライトを消す
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" 括弧入力時に括弧内に戻る
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>

" ウィンドウ移動
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" CTRL+TAB でタブ切替
noremap <C-Tab> gt
noremap <C-S-Tab> gT

nnoremap <Space> jzz
nnoremap <S-Space> kzz

" Load settings for each location.
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" テンプレートファイル
autocmd BufNewFile *.html 0r ~/.vim/skel/skel.html
autocmd BufNewFile *.css 0r ~/.vim/skel/skel.css

if has('mac')
  " let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/proc.so'
  let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/vimproc_mac.so'
endif

"" Plugin 設定
" -----------------------------------------------------

"" neocomplcache {{{
let g:neocomplcache_enable_at_startup = 1
function InsertTabWrapper()
    if pumvisible()
        return "\<c-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<c-n>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'
let g:neosnippet#snippets_directory='~/.vim/snippets'

map <c-o>s <Plug>NERDCommenterSexy

"" endtagcomment.vim {{{
let g:endtagcommentFormat = '<!-- /%id%class -->'
nnoremap ,t :<C-u>call Endtagcomment()<CR>

"" neosnippet {{{
" <C-k> にマッピング
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

"" Zen-coding {{{
" <C-z> にマッピング
:imap <C-z> <C-y>
:vmap <C-z> <C-y>

"" Less {{{
au! BufRead,BufNewFile *.less set filetype=less

"" velocity {{{
au BufRead,BufNewFile *.vm set ft=html syntax=velocity

"" unite.vim {{{
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    ;f [unite]
" 入力モードで開始する
let g:unite_enable_start_insert=1
let g:unite_split_rule="botright"

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
" ブックマークに追加
nnoremap <silent> [unite]d :<C-u>UniteBookmarkAdd<CR>
" 最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
"if executable('ag')
"  let g:unite_source_grep_command = 'ag'
"  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
"  let g:unite_source_grep_recursive_opt = ''
"  let g:unite_source_grep_max_candidates = 200
"endif

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

"" vimfiler {{{
let g:vimfiler_as_default_explorer = 1
" 新しいタブでファイルを開く
let g:vimfiler_edit_action = 'open'
nnoremap <silent> [unite]e :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <silent> [unite]i :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

"" memolist.vim {{{
map <Leader>mn  :MemoNew<CR>
map <Leader>ml  :MemoList<CR>
map <Leader>mg  :MemoGrep<CR>
let g:memolist_path = "~/Documents/memo"
let g:memolist_memo_suffix = "md"

let g:quickrun_config={}

"" syntastic {{{
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': ['css', 'javascript'],
  \ 'passive_filetypes': ['html', 'scss'] }

nnoremap <silent> <Leader>m :OverCommandLine<CR>%s/

" Tell Neosnippet about the other snippets
" let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'

"" open Kobito app {{{
function! s:open_kobito(...)
    if a:0 == 0
        call system('open -a Kobito '.expand('%:p'))
    else
        call system('open -a Kobito '.join(a:000, ' '))
    endif
endfunction

" 引数のファイル(複数指定可)を Kobitoで開く
" （引数無しのときはカレントバッファを開く
command! -nargs=* Kobito call s:open_kobito(<f-args>)
" Kobito を閉じる
command! -nargs=0 KobitoClose call system("osascript -e 'tell application \"Kobito\" to quit'")
" Kobito にフォーカスを移す
command! -nargs=0 KobitoFocus call system("osascript -e 'tell application \"Kobito\" to activate'")

"" vim-eazymotion {{{
let g:EasyMotion_leader_key = ';'

let g:EasyMotion_keys='hklyuiopnm,qwertzxcvbasdgjf;'

nmap s <Plug>(easymotion-s)
vmap s <Plug>(easymotion-s)
omap z <Plug>(easymotion-s)

map ;j <Plug>(easymotion-j)
map ;k <Plug>(easymotion-k)

let g:EasyMotion_startofline = 0

" smartcase
let g:EasyMotion_smartcase = 1

" Migemo
let g:EasyMotion_use_migemo = 1

nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)

let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
let g:vimshell_enable_smart_case = 1

" vundle
" -----------------------------------------------------

set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

 " Let NeoBundle manage NeoBundle
 " Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" neocomplcache.vim
NeoBundle 'Shougo/neocomplcache'

" neosnippet.vim
NeoBundle 'Shougo/neosnippet'

" Nerdcommenter
NeoBundle 'scrooloose/nerdcommenter'

" surround.vim
NeoBundle 'tpope/vim-surround'

" YankRing
NeoBundle 'chrismetcalf/vim-yankring'

" Zencoding
" Bundle 'mattn/zencoding-vim'
NeoBundle 'mattn/emmet-vim'

" html5.vim
NeoBundle 'othree/html5.vim'

" vim-less
NeoBundle 'groenewege/vim-less'

" vim-velocity
NeoBundle 'lepture/vim-velocity'

" vim-css3-syntax
NeoBundle 'hail2u/vim-css3-syntax'

" vim-browsereload-mac
NeoBundle 'tell-k/vim-browsereload-mac'

" MatchTag
NeoBundle "MatchTag"

" Syntastic
NeoBundle 'scrooloose/syntastic'

" vimshell
NeoBundle 'Shougo/vimshell'

" unite.vim
NeoBundle 'Shougo/unite.vim'

" neomru
NeoBundle 'Shougo/neomru.vim'

" vimfiler
NeoBundle 'Shougo/vimfiler.vim'

" memolist
NeoBundle 'glidenote/memolist.vim'

" git-vim
NeoBundle 'motemen/git-vim'

" Sass
"Bundle 'tpope/vim-haml'
NeoBundle 'cakebaker/scss-syntax.vim'

" vim over
NeoBundle 'osyo-manga/vim-over'

" easy motion
NeoBundle 'Lokaltog/vim-easymotion'

" ag.vim
NeoBundle 'rking/ag.vim'

" vim-qfreplace
NeoBundle 'thinca/vim-qfreplace'

filetype plugin indent on

NeoBundleCheck
