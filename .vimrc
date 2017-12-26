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

set showcmd
set hlsearch
set autoindent
set nostartofline
set ruler
set confirm
set mouse=a
set cmdheight=2
set number
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
set tabstop=4 shiftwidth=4 softtabstop=0
set expandtab

"" visible tab
set list
set listchars=tab:>.

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


