" Common style

set number			" show number of line
set nocompatible	" remove old vi config
set autoindent		" auto indent
" set expandtab     " 
set tabstop=4		" set tab width
set softtabstop=4	" set tab width
set shiftwidth=4	" set tab width
set nowrap			" default nowrap
set cursorline		" highlight current line
set incsearch		" set inc search
" set ignorecase	" search ignore case
set showmatch		" show match [/(/{ ...
" set mouse=a         " enable mouse
set t_Co=256		" use color256
set background=dark " background color is dark
set nohlsearch      " no highlight search

" Code style

" Set nasm type
au BufNewFile,BufRead *.asm set filetype=nasm

" Python highlight
" let g:python_highlight_all = 1

" C* indent
au BufNewFile,BufRead *.c,*.cpp,*.java,*.ino,*.pl,*.php,*.js,*.css set cindent

" Convert tab to space
au BufNewFile,BufRead *.py,*.vim,*.ey set expandtab

" Auto wrap for markdown, text
au BufNewFile,BufRead *.md,*.txt set wrap

" Json indent
function JsonShift()
	let g:indentLine_setConceal = 0
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
	set expandtab
endfunction
au BufNewFile,BufRead *.json call JsonShift()

" Highlight current line or column
hi CursorLine cterm=NONE ctermbg=Black guifg=NONE guibg=NONE
" hi CursorColumn cterm=NONE ctermbg=Black guifg=NONE guibg=NONE

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

" Initialize plugin system
call plug#end()

" Set vim color theme
colorscheme gruvbox

" Set nerdtree hotkey
map <C-n> :NERDTreeToggle<cr>

" Vim-Slime
let g:slime_target = "screen"
let g:slime_python_ipython = 1
let g:slime_paste_file = tempname()
let g:slime_default_config = {"sessionname": "si", "windowname": "0"}

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" Set git-gutter update time
set updatetime=100

" Set indent line character
let g:indentLine_char = '█'

" YouCompleteMe config
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
