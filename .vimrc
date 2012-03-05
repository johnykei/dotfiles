" GUI_MacVim設定
if has('gui_macvim')
    set guifont=Consolas:h16 " フォント指定
    set lines=90 columns=300 " ウィンドウサイズをセット はみだした部分は自動的に修正させて画面いっぱいに表示させる
    set guioptions-=T " ウィンドウ上部のタブ部分を無効に
    set imdisable " IMEを無効に
    "set tabstop=2
    "set shiftwidth=2
    set showtabline=2
    set tabstop=4
    set expandtab
    set shiftwidth=4
    set smartindent
    set showmatch
    set number
    "フルスクリーンモード
	"set fuoptions=maxvert,maxhorz
  	"autocmd GUIEnter * set fullscreen
endif

" encoding
set encoding=utf-8

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
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

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


" Plugin 設定
" -----------------------------------------------------

" neocomplcache設定
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

" for NERDCommenterToggle c-oでコメントアウト・コメント
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap <c-o> <Plug>NERDCommenterToggle
vmap <c-o> <Plug>NERDCommenterToggle
nmap <c-o>m <Plug>NERDCommenterMinimal
vmap <c-o>m <Plug>NERDCommenterMinimal
nmap <c-o>s <Plug>NERDCommenterSexy
vmap <c-o>s <Plug>NERDCommenterSexy

" endtagcomment.vim
let g:endtagcommentFormat = '<!-- /%id%class -->'
nnoremap ,t :<C-u>call Endtagcomment()<CR>

" <C-k> にマッピング
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" Zen-coding を<C-z> にマッピング
:imap <C-z> <C-y>
:vmap <C-z> <C-y>

" NERDTreeToggle を<F2>で開く
:map <F2> :NERDTreeToggle<CR>

" テンプレートファイル
autocmd BufNewFile *.html 0r ~/.vim/skel/skel.html
autocmd BufNewFile *.css 0r ~/.vim/skel/skel.css

" Less
au! BufRead,BufNewFile *.less set filetype=less

" velocity
au BufRead,BufNewFile *.vm set ft=html syntax=velocity

" QuickBuf
let g:qb_hotkey = ";;"

" Pathogen
" call pathogen#runtime_append_all_bundles()


" vundle
" -----------------------------------------------------

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" neocomplcache.vim
Bundle 'Shougo/neocomplcache'

" neocomplcache-snippets-complete.vim
Bundle 'Shougo/neocomplcache-snippets-complete'

" Nerdcommenter
Bundle 'scrooloose/nerdcommenter'

" Nerdtree
Bundle 'scrooloose/nerdtree'

" QuickBuf
Bundle 'QuickBuf'

" surround.vim
Bundle 'tpope/vim-surround'

" YankRing
Bundle 'chrismetcalf/vim-yankring'

" Zencoding
Bundle 'mattn/zencoding-vim'

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

