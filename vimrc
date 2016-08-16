" Set up indenting for different file types
filetype indent on

" Use 4 spaces instead of tab
:set expandtab
:set ts=4
:set shiftwidth=4
set undofile
set smarttab

" AutoIndent
set autoindent

:set nu " Line numbers

" Show row and column number
:set ruler

set backspace=indent,eol,start

" Set up braces blinking
set showmatch
set matchtime=2 " how many times to blink

" Make sure syntax highlighting is enabled
syntax enable
syntax on

set noswapfile

" No annoying sound on errors
set noerrorbells
set visualbell
set t_vb=
set tm=500

" Ignore case when searching
set ignorecase

" Height of the command bar
set cmdheight=2

"insert one character
noremap Q a<Space><Esc>r
noremap q i<Space><Esc>r

function! Tab_Or_Complete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
    endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

:set wrap
:set linebreak

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


" Centers the next result on the page
map N Nzz
map n nzz

" add useful stuff to title bar (file name, flags, cwd)
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f
    set titlestring+=%h%m%r%w
    set titlestring+=\ -\ %{v:progname}
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
endif

" --- list chars ---
" list spaces and tabs to avoid trailing spaces and mixed indentation
" see key mapping at the end of file to toggle `list`
set listchars=tab:▹\ ,trail:·,nbsp:⚋
set fillchars=fold:-
set list

" command completion
set wildmenu                " Hitting TAB in command mode will
set wildchar=<TAB>          "   show possible completions.
set wildmode=list:longest
set wildignore+=*.DS_STORE,*.db,node_modules/**,*.jpg,*.png,*.gif

" AUTOCOMPLETE CSS CLASSES WITH DASHES
" broken by youcompleteme - had to edit YCM source https://gist.github.com/mutewinter/7186595
function! KeywordsAll()
    setl iskeyword=@,48-57,192-255,\@,\$,%,-,_
endfunc

function! KeywordsBasic()
    setl iskeyword=@,48-57,192-255
endfunc

" improve the 'search word under cursor' behavior
nnoremap * :silent call KeywordsAll() * :silent call KeywordsBasic()
nnoremap # :silent call KeywordsAll() # :silent call KeywordsBasic()

" make sure `complete` works as expected for CSS class names without
" messing with motions (eg. '.foo-bar__baz') and we make sure all
" delimiters (_,-,$,%,.) are treated as word separators outside insert mode
autocmd InsertEnter,BufLeave * :silent call KeywordsAll()
autocmd InsertLeave,BufEnter * :silent call KeywordsBasic()

" yes, we need to duplicate it on VimEnter for some weird reason
autocmd VimEnter * nnoremap * :silent call KeywordsAll()<CR> *
autocmd VimEnter * nnoremap # :silent call KeywordsAll()<CR> #

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" movement by screen line instead of file line (for text wrap)
nnoremap j gj
nnoremap <down> gj
nnoremap k gk
nnoremap <up> gk

" automatic esc, really uncommon to type jj,jk
inoremap jj <ESC>
inoremap jk <Esc>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
autocmd BufWritePre * :%s/\s\+$//e

" needed for nerdcommenter
filetype plugin on

" Pathogen
execute pathogen#infect()

" Solarized
syntax enable
set background=dark
colorscheme solarized
let g:solarized_visibility = "low"

" Nerd Tree
map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" handlebars abbreviations
let g:mustache_abbreviations = 1

" for use with delimitmate - split autocompleted bracket/paren onto new line
imap <C-c> <CR><Esc>O

" tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>

" Control P
set runtimepath^=~/.vim/bundle/ctrlp.vim

" --- Syntastic : Linting / Error check ---
" let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
" close/open location list (errors)
noremap <silent><leader>lc :lcl<CR>
noremap <silent><leader>lo :lw<CR>
noremap <silent><leader>ln :lnext<CR>
noremap <silent><leader>lp :lprev<CR>

" --- snipmate ---
let g:snips_trigger_key = '<C-Tab>'

" Emmet
let g:user_emmet_leader_key='<C-e>'

noremap <S-l> gt
noremap <S-h> gT

" fontsize
:set guifont=Bitstream\ Vera\ Sans\ Mono:h16

" css colors:
let g:cssColorVimDoNotMessMyUpdatetime = 1

" Console log from insert mode; Puts focus inside parentheses
imap cll console.log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');<Enter>console.log();<Enter>console.log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');<Esc>==kf(a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap cll ocll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap cll ocll

au BufNewFile,BufRead *.groovy  setf groovy

if did_filetype()
    finish
endif
if getline(1) =~ '^#!.*[/\\]groovy\>'
    setf groovy
endif

set showcmd
set cursorline

set hlsearch   " highlight search results
set incsearch  " incremental search
