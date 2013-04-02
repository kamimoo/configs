" vim:set ts=8 sts=2 sw=2 tw=0:
"

"---------------------------------------------------------------------------
scriptencoding utf-8
"" neobundle
set nocompatible
filetype off
filetype plugin indent off

if has('vim_starting')
  set rtp+=~/.vim/bundles/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundles'))


" 1.bundles.vimでプラグインのリストを管理
" 2.EditBundlesでこのリストの編集を開始
" 3.リストを保存することでg:bundlesを更新してBundleCleanする
let $bundles_file=$HOME.'/configs/dot.vim/NeoBundle.vim'
com! EditBundles :e $bundles_file

augroup NeoBundle
  au BufWritePost $bundles_file call neobundle#config#init()
  au BufWritePost $bundles_file source $bundles_file
  au BufWritePost $bundles_file NeoBundleClean
  au BufWritePost $bundles_file NeoBundleInstall
augroup END

source $bundles_file
filetype plugin indent on

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

:source $VIMRUNTIME/macros/matchit.vim

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

" CJKの曖昧幅文字の幅を全角にする
set ambiwidth=double

if !has('gui_running')
  set notimeout
  set ttimeout
  set timeoutlen=100
endif


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
colorscheme xoria256

"---------------------------------------------------------------------------
" キー設定

" タブ切り替え
nnoremap <C-l> gt
nnoremap <C-h> gT

" PASTEモードトグル
nnoremap <Space>tp :<C-u>set paste!<CR>

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
  autocmd FileType haxe setlocal sta tabstop=4 shiftwidth=4 expandtab autoindent smartindent
  autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 0
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd BufWritePost *.php :call PHPLint()
endif

augroup filetypedetect
  au BufNewFile,BufRead *.json setf javascript
  au BufNewFile,BufRead *.ml setlocal ft=omlet
  au BufNewFile,BufRead *.mobile.erb let b:eruby_subtype='html'
  au BufNewFile,BufRead *.mobile.erb set filetype=eruby
augroup end

let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1

"---------------------------------------------------------------------------
"" neocomplcache
" 補完ウィンドウの設定
"let completeopt=preview,menuone
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_ignore_case = 1
" カーソルより後のキーワードパターンを認識
if !exists('g:neocomplcache_next_keyword_patterns')
  let g:neocomplcache_next_keyword_patterns = {}
endif

" スニペット補完
"let g:neocomplcache_snippets_disable_runtime_snippets = 1
" スニペットファイルの置き場所
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'

" 改行で補完ウィンドウを閉じる
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
"tabで補完候補の選択を行う
noremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
"C-h, BSで補完ウィンドウを確実に閉じる
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<BS>"
"C-yで補完候補の確定
inoremap <expr><C-y> neocomplcache#close_popup()
"C-eで補完のキャンセルし、ウィンドウを閉じる。ポップアップが開いていないときはEndキー
inoremap <expr><C-e> pumvisible() ? neocomplcache#cancel_popup() : "\<End>"
"C-gで補完を元に戻す
inoremap <expr><C-g> neocomplcache#undo_completion()
"vim標準のキーワード補完を置き換える
inoremap <expr><C-n> neocomplcache#manual_keyword_complete()
"C-pで上キー
inoremap <C-p> <Up>
"補完候補の共通文字列を補完する(シェル補完のような動作)
inoremap <expr><C-l> neocomplcache#complete_common_string()
"スニペットを展開する。スニペットが関係しないところでは行末まで削除
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
"オムニ補完の手動呼び出し
inoremap <expr><C-Space> neocomplcache#manual_omni_complete()

"スニペットファイルを編集する
nnoremap <Space>nes :NeoComplCacheEditSnippets

" Enable heavy omni completion
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.haxe = '\v([\]''"]|\w)(\.|\()'
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

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
" eskk
map! <C-j> <Plug>(skk-toggle-im)
let g:eskk#large_dictionary = expand('~/skk/SKK-JISYO.L')
let g:eskk#egg_like_newline = 1
let g:eskk#show_candidates_count = 0

"---------------------------------------------------------------------------
" skk
"map! <C-j> <Plug>(skk-toggle-im)
"let g:skk_large_jisyo = expand('~/skk/SKK-JISYO.L')
"let g:skk_egg_like_newline = 1


"---------------------------------------------------------------------------
" vim-javascript
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

"---------------------------------------------------------------------------
" tagbar
nmap <F8> :TagbarToggle<CR>


"---------------------------------------------------------------------------
" syntastic
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': ['html'] }

"---------------------------------------------------------------------------
" riv
let uname = system('uname')
if uname =~? "Darwin"
  let g:riv_web_browser = "open -a Firefox"
endif
let g:riv_html_code_hl_style = "friendly"
