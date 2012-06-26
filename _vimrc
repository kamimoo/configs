" vim:set ts=8 sts=2 sw=2 tw=0:
"

"---------------------------------------------------------------------------
scriptencoding utf-8
"" vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

filetype plugin indent on

" 1.bundles.vimでプラグインのリストを管理
" " 2.EditBundlesでこのリストの編集を開始
" " 3.リストを保存することでg:bundlesを更新してBundleCleanする
let $bundles_file=$HOME.'/configs/dot.vim/bundles.vim'
com! EditBundles :e $bundles_file

augroup Vundle
  au BufWritePost $bundles_file call vundle#config#init()
  au BufWritePost $bundles_file source $bundles_file
  au BufWritePost $bundles_file BundleClean
  au BufWritePost $bundles_file BundleInstall
augroup END

source $bundles_file

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 検索キーワードのハイライト
set hlsearch
" インクリメンタルサーチ
set incsearch

if has("migemo")
  set migemo
endif
"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=8
" タブをスペースに展開しない
set noexpandtab
" 自動的にインデントする
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 括弧入力時に対応する括弧を表示
set showmatch
" コマンドライン補完するときに強化されたものを使う
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1	" ぶら下り可能幅

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を表示
set number
" ルーラーを表示
set ruler
" タブや改行を表示
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" カーソルの行に下線を表示
if v:version >= 700
  set cursorline
endif
" ステータス行のフォーマット
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P
" シンタックスハイライト
syntax on


"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない
set nobackup
" swpファイルを作成しない
set noswapfile


"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
"if has('unix') && !has('gui_running')
"  let uname = system('uname')
"  if uname =~? "linux"
"    set term=builtin_linux
"  elseif uname =~? "freebsd"
"    set term=builtin_cons25
"  elseif uname =~? "Darwin"
"    set term=beos-ansi
"  else
"    set term=builtin_xterm
"  endif
"  unlet uname
"endif

" 画面を256色にする
set t_Co=256
"colorscheme ChocolateLiquor

"---------------------------------------------------------------------------
" ファイルタイプごとの設定
if has("autocmd")
  autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType omlet filetype plugin indent on
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType c,css,html,smarty,javascript,xml,ruby,vim,cucumber setlocal tabstop=2 shiftwidth=2 expandtab autoindent smartindent
  autocmd FileType php,lua setlocal tabstop=4 shiftwidth=4 expandtab autoindent smartindent
  autocmd BufWritePost *.php :call PHPLint()
endif

augroup filetypedetect
  au BufNewFile,BufRead *.json setf javascript
  au BufNewFile,BufRead *.ml setlocal ft=omlet
augroup end

let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1

"---------------------------------------------------------------------------
"" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1

"---------------------------------------------------------------------------
" 関数

" PHPの保存時に文法チェックする
function! PHPLint()
  let result = system('php -l ' . bufname(""))
  let headPart = strpart(result, 0, 16)

  if headPart != "No syntax errors"
    echo result
  endif
endfunction

map <F2> <Esc>:1,$!xmllint --format -<CR>

"---------------------------------------------------------------------------
" 末尾スペースをハイライト
function! WhitespaceEOL()
  highlight WhitespaceEOL cterm=underline ctermbg=red ctermfg=red gui=underline guifg=red guibg=red
  silent! match WhitespaceEOL /[[:blank:]]\+$/
endfunction
augroup WhitespaceEOL
  autocmd!
  autocmd VimEnter,BufEnter,WinEnter,ColorScheme * call WhitespaceEOL()
augroup END

"---------------------------------------------------------------------------
" VimShell
let g:vimproc_dll_path=$HOME.'/.vim/proc.so'
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]{%p}", "(%s)-[%b|%a]%p")'
let g:vimshell_prompt = '% '
let g:vimshell_enable_auto_slash = 1

let g:Powerline_symbols = 'fancy'

"---------------------------------------------------------------------------
" skk
map! <C-j> <Plug>(skk-toggle-im)
let g:skk_large_jisyo = expand('~/skk/SKK-JISYO.L')
let g:skk_egg_like_newline = 1

"---------------------------------------------------------------------------
" vim-javascript
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
