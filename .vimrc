" Theme
if has("gui_running")
  colo   inkpot
else
 colo ron
endif
" load filetype plugins
filetype plugin on
" load indent files for specific filetypes
filetype indent on
set guioptions-=T
set guifont="Terminus 16"
set nocompatible
set incsearch 
set nohlsearch 
set novisualbell 
set termencoding=utf-8 
set autoindent 
set backspace=indent,eol,start 
set fdm=marker
syntax on
" KEys
ino <Down> <C-O>gj
ino <Up> <C-O>gk
nno <Down> gj
nno <Up> gk
set pt=<F5> shm=I tm=750 nomore modelines=5 hls!
map <S-Insert> <MiddleMouse>
nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/
nno <F4> :set nu!<bar>set nu?<CR>
map <F1> :MarksBrowser<cr>
map <F3> :w!<CR>:!aspell check %<CR>:e! %<CR>
:autocmd FileType mail :nmap <F8> :w<CR>:!aspell -d en,uk,ru -e -c %<CR>:e<CR>
" F1 - bookmarks browser
map <F1> :MarksBrowser<cr>
vmap <F1> <esc>:MarksBrowser<cr>
imap <F1> <esc>:MarksBrowser<cr>
" F2 Explore
map <F2> :Texplore<cr>
vmap <F2> <esc>:Texplore<cr>i
imap <F2> <esc>:Texplore<cr>i
" number of pixel lines inserted between characters
set linespace=0
" command-line completion operates in an enhanced mode
set wildmenu
" Show the line and column number of the cursor position
set ruler
set showcmd 
" Number of screen lines to use for the command-line
set cmdheight=2
" Print the line number in front of each line
set number
" tell us when any line is changed via : commands
set report=0
" what to show when I hit :set list
set list listchars=tab:»·,trail:·,eol:¶,extends:>





set wcm=<Tab> 
" codepage 
menu Enc.koi8-r :e ++enc=koi8-r<CR>
menu Enc.windows-1251 :e ++enc=cp1251<CR>
menu Enc.cp866 :e ++enc=cp866<CR>
menu Enc.utf-8 :e ++enc=utf8 <CR>
map <F7>   :emenu Enc.<TAB>
" Auto complete
function InsertTabWrapper()
     let col = col('.') - 1
     if !col || getline('.')[col - 1] !~ '\k'
         return "\<tab>"
     else
         return "\<c-p>"
     endif
endfunction
imap <tab> <c-r>=InsertTabWrapper()<cr>
set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t
set completeopt-=preview
set completeopt+=longest
set mps-=[:]
" how automatic formatting is to be done
set formatoptions=tcrqn
" take indent for new line from previous line
set autoindent
" smart autoindenting for C programs
set smartindent
" do c-style indenting
set cindent
" tab spacing (settings below are just to unify it)
set tabstop=8
" unify
set softtabstop=8
" unify
set shiftwidth=8
" real tabs please!
set noexpandtab
" do not wrap lines
set nowrap
" use tabs at the start of a line, spaces elsewhere
set smarttab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If you don't have it download it from http://ctags.sourceforge.net/
" To get taglists download it from http://www.geocities.com/yegappan/taglist
" Location of ctags
let Tlist_Ctags_Cmd = '/bin/ctags'
" order by
let Tlist_Sort_Type = "name"
" split to the right side of the screen
let Tlist_Use_Right_Window = 1
" show small meny
let Tlist_Compart_Format = 1
" if you are the last, kill yourself
let Tlist_Exist_OnlyWindow = 1
" Do not close tags for other files
let Tlist_File_Fold_Auto_Close = 0
" Do not show folding tree
let Tlist_Enable_Fold_Column = 0


