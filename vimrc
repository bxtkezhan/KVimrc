"编辑风格.

set number			" 显示行号 
set nocompatible	" 去掉vi一致性模式，避免旧版本bug
set autoindent		" 自动缩进
" set expandtab     " 缩进转空格
set tabstop=4		" Tab键的宽度
set softtabstop=4	" |
set shiftwidth=4	" 统一缩进为4
set nowrap			" 设置取消自动换行
set cursorline		" 高亮当前行 
set incsearch		" 设置增量查找
" set ignorecase	" 设置忽略大小写搜索
set showmatch		" 括号匹配跳转
"set mouse=a         " 开启鼠标

"代码风格.

"-NASM 高亮
au BufNewFile,BufRead *.asm set filetype=nasm

"-C 族缩进
au BufNewFile,BufRead *.c,*.cpp,*.java,*.ino,*.pl,*.php,*.js,*.css set cindent

"-Python Tab转空格
au BufNewFile,BufRead *.py,*.vim set expandtab

"-TEXT 自动换行
au BufNewFile,BufRead *.md,*.txt set wrap

"-高亮行列配置
hi CursorLine cterm=NONE ctermbg=Black guifg=NONE guibg=NONE
" hi CursorColumn cterm=NONE ctermbg=Black guifg=NONE guibg=NONE

" 插件相关配置.

"设置 Leader 参量.
let mapleader=","

"-Python 运行
map <Leader>pr :!python3 %<cr>
map <Leader>p2r :!python2 %<cr>
map <Leader>p3r :!python3 %<cr>

"拓展优化.

"-退出插入模式，关闭提示栏目
au InsertLeave * if pumvisible() == 0|pclose|endif

"-Tagbar，NERDTree 快捷键
map <Leader>tb :TagbarToggle<cr>
map <Leader>nt :NERDTreeToggle<cr>

"-syntastic 设置
" let g:syntastic_error_symbol = "✗"
" let g:syntastic_warning_symbol = "⚠"
" let g:ycm_show_diagnostics_ui = 0
let g:ycm_python_binary_path = '/usr/bin/python3'

"-VimSay 设置
let g:vs_client_id = 'Your client id'
let g:vs_client_secret = 'Your client secret'
let g:vs_cuid = 'Your cuid'
let g:vs_lan = 'zh' " Set to zh
let g:vs_ctp =  1	" Default 1
let g:vs_spd =  5	" Default 5
let g:vs_pit =  5	" Default 5
let g:vs_vol =  9	" Default 9
map <Leader>mc :VSC<cr>
map <Leader>mr :VSR<cr>

"-VundleVim
set nocompatible " be iMproved, required
filetype off     " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" yapf, html5-print
map <Leader>yp :%!yapf<cr>
map <Leader>hp :%!html5-print -s4 %<cr>
