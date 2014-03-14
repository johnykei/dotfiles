"" 基本設定 {{{
set guifont=Source_Code_Pro:h16 " フォント指定
set lines=90 columns=300 " ウィンドウサイズをセット はみだした部分は自動的に修正させて画面いっぱいに表示させる
set guioptions-=T " ウィンドウ上部のタブ部分を無効に
"set noimdisableactivate
"set imdisable " IMEを無効に
set showtabline=2
set expandtab
"set tabstop=2
"set shiftwidth=2
set tabstop=4
set shiftwidth=4
set smartindent
set showmatch
set number
set noerrorbells " ビープ音を消す
set vb t_vb=  " ビープ音を消す
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

let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'
let g:neosnippet#snippets_directory='~/.vim/snippets'

"" for NERDCommenterToggle {{{
" c-oでコメントアウト・コメント
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap <c-o> <Plug>NERDCommenterToggle
vmap <c-o> <Plug>NERDCommenterToggle
nmap <c-o>m <Plug>NERDCommenterMinimal
vmap <c-o>m <Plug>NERDCommenterMinimal
nmap <c-o>s <Plug>NERDCommenterSexy
vmap <c-o>s <Plug>NERDCommenterSexy

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

""" QuickBuf {{{
let g:qb_hotkey = ";;"

"" unite.vim {{{
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Leader>f [unite]
" 入力モードで開始する
let g:unite_enable_start_insert=1
let g:unite_split_rule="botright"
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

let g:EasyMotion_startofline = 0

" smartcase
let g:EasyMotion_smartcase = 1

" Migemo
let g:EasyMotion_use_migemo = 1

let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
let g:vimshell_enable_smart_case = 1

" vundle
" -----------------------------------------------------

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" neocomplcache.vim
Bundle 'Shougo/neocomplcache'

" neosnippet.vim
Bundle 'Shougo/neosnippet'

" snipmate-snippets
Bundle 'honza/snipmate-snippets'

" Nerdcommenter
Bundle 'scrooloose/nerdcommenter'

" Nerdtree
" Bundle 'scrooloose/nerdtree'

" QuickBuf
Bundle 'QuickBuf'

" surround.vim
Bundle 'tpope/vim-surround'

" YankRing
Bundle 'chrismetcalf/vim-yankring'

" Zencoding
" Bundle 'mattn/zencoding-vim'
Bundle 'mattn/emmet-vim'

" ack.vim
Bundle 'mileszs/ack.vim'

" html5.vim
Bundle 'othree/html5.vim'

" vim-less
Bundle 'groenewege/vim-less'

" vim-velocity
Bundle 'lepture/vim-velocity'

" vim-css3-syntax
Bundle 'hail2u/vim-css3-syntax'

" vim-browsereload-mac
Bundle 'tell-k/vim-browsereload-mac'

" Endtagcomment.vim
Bundle 'git://gist.github.com/411828.git'

" mru.vim
" Bundle 'vim-scripts/mru.vim'

" FuzzyFinder
" Bundle 'FuzzyFinder'

" Auto Close
" Bundle 'AutoClose'

" MatchTag
Bundle "MatchTag"

" Syntastic
Bundle 'scrooloose/syntastic'

" ctrip
"Bundle 'kien/ctrlp.vim'

" vimproc
Bundle 'Shougo/vimproc'

" vimshell
Bundle 'Shougo/vimshell'

" unite.vim
Bundle 'Shougo/unite.vim'

" neomru
Bundle 'Shougo/neomru.vim'

" neomru
Bundle 'Shougo/vimfiler.vim'

" memolist
Bundle 'glidenote/memolist.vim'

"Changed
"Bundle 'Changed'

" git-vim
Bundle 'motemen/git-vim'

" Sass
"Bundle 'tpope/vim-haml'
Bundle 'cakebaker/scss-syntax.vim'

" Sass Compile
"Bundle 'AtsushiM/sass-compile.vim'

" CSScomb
Bundle 'csscomb/CSScomb-for-Vim'

" vim over
Bundle 'osyo-manga/vim-over'

" easy motion
Bundle 'Lokaltog/vim-easymotion'
