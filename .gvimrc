syntax on
set transparency=10 " 透明度を指定
set guifont=Source_Code_Pro:h16 " フォント指定
set lines=90 columns=300 " ウィンドウサイズをセット はみだした部分は自動的に修正させて画面いっぱいに表示させる
set guioptions-=T " ウィンドウ上部のタブ部分を無効に
set noimdisableactivate
"set imdisable " IMEを無効に
set guioptions-=T
set showtabline=2
set expandtab
"set tabstop=2
"set shiftwidth=2
set tabstop=4
set shiftwidth=4
set smartindent
"set autoindent
set showmatch
set number
set incsearch
set wildmenu
set nobackup
set noswapfile
"colorscheme desert " カラースキーマを指定
"colorscheme railscasts " カラースキーマを指定
"colorscheme molokai " カラースキーマを指定
"colorscheme monokai " カラースキーマを指定
"colorscheme wombat " カラースキーマを指定
"colorscheme github " カラースキーマを指定
"colorscheme guardian " カラースキーマを指定
"colorscheme solarized " カラースキーマを指定
"colorscheme codeschool " カラースキーマを指定
"colorscheme zenburn " カラースキーマを指定
"colorscheme mustang " カラースキーマを指定
colorscheme hybrid " カラースキーマを指定

" vimshell
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_right_prompt = ''
let g:vimshell_max_command_history = 3000
let g:vimshell_enable_smart_case = 1
let g:vimshell_prompt = $USER."% "

nnoremap <silent> vs :VimShell<CR>
nnoremap <silent> vsc :VimShellCreate<CR>
nnoremap <silent> vp :VimShellPop<CR>

if has('multi_byte_ime') || has('xim')
  highlight Cursor guibg=khaki guifg=slategrey
  highlight CursorIM guifg=NONE guibg=DarkRed
endif
