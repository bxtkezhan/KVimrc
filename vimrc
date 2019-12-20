" Coding and format config
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileformats=unix,dos
set termencoding=utf-8
set formatoptions+=B

" Common style

set number			" show number of line
set nocompatible	" remove old vi config
set autoindent		" auto indent
set smartindent		" smart indent
" set expandtab     " 
set tabstop=4		" set tab width
set softtabstop=4	" set tab width
set shiftwidth=4	" set tab width
set nowrap			" default nowrap
set cursorline		" highlight current line
" set cursorcolumn	" highlight current column
set incsearch		" set inc search
" set ignorecase	" search ignore case
set showmatch		" show match [/(/{ ...
" set mouse=a         " enable mouse
set t_Co=256		" use color256
set background=dark" background color is dark
set nohlsearch      " no highlight search
" set laststatus=2	" set position of the status bar

" File type config
filetype on
filetype plugin on
filetype indent on

" Code style

" Reset file type
au BufNewFile,BufRead *.asm set filetype=nasm
au BufNewFile,BufRead *.cy set filetype=cylang
au BufNewFile,BufRead *.txt set filetype=text

" Python highlight
" let g:python_highlight_all = 1

" C* indent
au FileType c,cpp,java,javascript,css set cindent

" Convert tab to space
au FileType nasm,c,cpp,java,html,css,javascript,python,vim,cylang set expandtab

" Auto wrap for markdown, text
au FileType markdown,text set wrap

" Json indent
function JsonShift()
	let g:indentLine_setConceal = 0
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
	set expandtab
endfunction
au FileType json call JsonShift()

" Highlight current line or column
hi CursorLine cterm=NONE ctermbg=Black guifg=NONE guibg=NONE
hi CursorColumn cterm=NONE ctermbg=Black guifg=NONE guibg=NONE

" Set Leader key
let mapleader=","

" Run python
map <Leader>pr :!python3 %<cr>
map <Leader>p2r :!python2 %<cr>

" Run yapf to format python code
map <Leader>yp :%!yapf<cr>

" Open right terminal
map <Leader>vt :rightbelow vsplit<cr>:terminal ++curwin<cr>

" Plugin config

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'morhetz/gruvbox'

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

Plug 'jiangmiao/auto-pairs'

Plug 'jpalardy/vim-slime'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'tpope/vim-surround'

Plug 'tomtom/tcomment_vim'

Plug 'airblade/vim-gitgutter'

Plug 'ycm-core/YouCompleteMe'

Plug 'Yggdroot/indentLine'

Plug 'Chiel92/vim-autoformat'

Plug 'majutsushi/tagbar'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()

" Set vim color theme
colorscheme gruvbox

" Set nerdtree hotkey
map <C-n> :NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1

" Set tagbar hotkey
map <C-t> :TagbarToggle<cr>

" Vim-Slime
let g:slime_target = "screen"
let g:slime_python_ipython = 1
let g:slime_paste_file = tempname()
let g:slime_default_config = {"sessionname": "si", "windowname": "0"}

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" Set git-gutter update time
set updatetime=100

" Set indent line character
let g:indentLine_char = '█'

" YouCompleteMe config
let g:ycm_add_preview_to_completeopt = 0
set completeopt-=preview
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" let g:ycm_error_symbol = '✗'
let g:ycm_error_symbol = '🤣'
" let g:ycm_warning_symbol = '⚠'
let g:ycm_warning_symbol = '🤔'
let g:ycm_filetype_whitelist = {
    \'nasm': 1,
    \'c': 1,
    \'cpp': 1,
    \'java': 1,
    \'html': 1,
    \'css': 1,
    \'javascript': 1,
    \'python': 1,
    \'cylang': 1,
    \'markdown': 1,
    \'vim': 1,
    \}
nnoremap <leader>jd :YcmCompleter GoTo<cr>

" Airline config
let g:airline#extensions#tabline#enabled = 1

" Tab hotkey
map <Leader>te :tabedit<cr>:NERDTreeToggle<cr>
map <Leader>tc :tabclose<cr>
