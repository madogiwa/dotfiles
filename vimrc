
"" ============================================================================
"" plugin manager (vim-plug)
"" ============================================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"" Clipboardからのペースト時に自動的にpasteモードにする
Plug 'ConradIrwin/vim-bracketed-paste'

"" コメントアウトを便利にする
Plug 'tomtom/tcomment_vim'

"" ステータスラインを便利にする
Plug 'itchyny/lightline.vim'

"" ステータスラインにgit branch名を表示する
Plug 'itchyny/vim-gitbranch'

"" Terraform
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'juliosueiras/vim-terraform-completion', { 'for': 'terraform' }

"" File Viewer
Plug 'lambdalisue/fern.vim'

"" tmuxのfocus変更をvimで使えるようにする？
Plug 'tmux-plugins/vim-tmux-focus-events'


call plug#end()

"" ============================================================================
"" plugins config
"" ============================================================================

"" ----------------------------------------------------------------------------
"" lightline
"" ----------------------------------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

"" ----------------------------------------------------------------------------
"" Terraform
"" ----------------------------------------------------------------------------

"" 保存時に自動的にfmtを実行する
let g:terraform_fmt_on_save = 1


"" ============================================================================
"" general
"" ============================================================================

"" modelineを有効化
set modeline

"" modelineの文字列を探す行数
set modelines=10

"" enable coloring
syntax on

"" http://vimwiki.net/?vimrc%2F9
set hidden

"" 補完結果のビジュアル表示を無効化
set nowildmenu

"" ファイル名の補完時に入力文字にリスト表示+一致した部分までを補完
set wildmode=list:longest

"" 現在行を表示する
"" 下線を削除、行番号の背景色を変更
set cursorline
hi clear CursorLine
hi CursorLineNr ctermbg=4 ctermfg=0

"" 行番号を表示
set number
hi LineNr ctermbg=0 ctermfg=6

"" ステータスラインに-- INSERT --などを表示しない
"" lightline.vimで代用できるため
set noshowmode

set showcmd
set hlsearch
set autoindent
set indentexpr=
set nostartofline
set ruler
set confirm
set mouse=a
set cmdheight=2
set notimeout ttimeout ttimeoutlen=120
nnoremap <C-L> :nohl<CR><C-L>

"" for japanese
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,ucs-2le,ucs-2

"" correct some symbolic character's width = double
if exists ('&ambiwidth')
  set ambiwidth=double
endif

"" detect linefeed code
set fileformats=unix,dos,mac

"" tabstop
set tabstop=2 shiftwidth=2 softtabstop=0
set expandtab

"" visible tab & eol
set list
set listchars=tab:»-,eol:↵

highlight NonText    ctermfg=23 ctermbg=none cterm=BOLD

"" don't insert to eol the end of file
set noeol

"" enable incremental search
set incsearch

"" ignore case when not mixed lower and upper case
set ignorecase
set smartcase

"" don't create .swap file
set noswapfile

"" use OS X clipboard
set clipboard=unnamed

"" can delete indent,eol,before start
set backspace=indent,eol,start

"" display into status line encoding and return code
set laststatus=2
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P

"" autocommands
if has("autocmd")
  "" When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

  autocmd FileType go setlocal sw=4 sts=0 ts=4 et
endif


"" ============================================================================
"" tab
"" ============================================================================

"" 二つ以上のタブがある場合のみ表示
set showtabline=1

"" タブ操作prefixキー
nnoremap  [Tab]  <Nop>
nmap      t      [Tab]

"" 1から9キーで番号のタブに切り替え
for n in range(1, 9)
    execute 'nnoremap <silent> [Tab]'.n ':<C-u>tabnext'.n.'<CR>'
endfor

"" 新しいタブを作る
map <silent> [Tab]c :tablast <bar> tabnew<CR>

"" タブを閉じる
map <silent> [Tab]k :tabclose<CR>

"" 次のタブ
map <silent> [Tab]n :tabnext<CR>

"" 前のタブ
map <silent> [Tab]p :tabprevious<CR>


"" ============================================================================
"" buffer
"" ============================================================================

"" バッファ操作prefixキー
nnoremap  [Buffer]  <Nop>
nmap      <C-e>     [Buffer]

"" 1から9キーで番号のバッファに切り替え
for n in range(1, 9)
    execute 'nnoremap <silent> [Buffer]'.n ':b '.n.'<CR>'
endfor

"" バッファのリストを表示
map <silent> [Buffer]l :ls<CR>

"" 新しいバッファを作る
map <silent> [Buffer]c :enew<CR>

"" バッファを閉じる
map <silent> [Buffer]k :bd<CR>

"" 次のバッファ
map <silent> [Buffer]n :bn<CR>

"" 前のバッファ
map <silent> [Buffer]p :bp<CR>


"" ============================================================================
"" key remap
"" ============================================================================

let mapleader = "\<SPACE>"

"" ----------------------------------------------------------------------------
"" command mode
"" ----------------------------------------------------------------------------

"" emacs like keys
cnoremap <C-g> <Esc>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>

cnoremap <C-d> <Del>
cnoremap <C-h> <BS>

cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

