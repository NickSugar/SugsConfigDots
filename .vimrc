set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'


" ================================================
" Settings 
" ================================================

	set backupdir=$TMPDIR//
	set directory=$TMPDIR//	

	set highlight+=@:ColorColumn          " ~/@ at end of window, 'showbreak'
	set highlight+=N:DiffText             " make current line number stand out a little
	set highlight+=c:LineNr               " blend vertical separators with line numbers
	set lazyredraw 

	let NERDTreeQuitOnOpen=1

	let NERDTreeShowHidden=1

	set clipboard=unnamed

	set foldmethod=indent

	set number relativenumber

	" Split screen
	set splitbelow
	set splitright

	" Searches in all subdirectories for files
	set path+=**

	" Display all matching files when tab complete
	set wildmenu

	set showcmd

	set hlsearch

	set ignorecase
	set smartcase

	set backspace=indent,eol,start

	set confirm

	set visualbell

	" set t_vb=

	set cmdheight=2


	" Creates the 'tags' file
	" command! MakeTags !ctags -R .
	set tags=./tags;,tags;

" ================================================
" End Settings 
" ================================================

" ================================================
" Mappings
" ================================================

	nnoremap <Space> <nop>
	let mapleader = "\<Space>"

	nnoremap <leader>t :Gstatus<CR>

	nnoremap <leader>v :e ~/.vimrc<CR>

	nnoremap <leader>n :NERDTreeToggle<CR>

	nnoremap <C-L> :nohl<CR><C-L>

	" Maps Ctrl-C (Case or CONST) to macro that UPPERCASE last word
	inoremap <C-C> <ESC>BgUEEa

	" Maps Alt-J and Alt-K to macro for moving lines up and down
	nnoremap ∆ :m .+1<CR>==
	nnoremap ˚ :m .-2<CR>==
	inoremap ∆ <Esc>:m .+1<CR>==gi
	inoremap ˚ <Esc>:m .-2<CR>==gi
	vnoremap ∆ :m '>+1<CR>gv=gv
	vnoremap ˚ :m '<-2<CR>gv=gv

	" So that if CapsLock is on, 'zz'(Center window on cursor) doesn't 'ZZ'(:wq)
	nnoremap ZZ zz

	" Enter adds new line (Stays in Normal mode)
	" Alt-p adds 'Padding' line below
	" Alt-o adds 'Over Padding'
	nnoremap π Moxx<Tab>zz
	nnoremap ø MOxx<Tab>zz

" ================================================
" End Mappings
" ================================================

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" ================================================
" Plugins
" ================================================
 
	Bundle 'Valloric/YouCompleteMe'


	let g:ycm_autoclose_preview_window_after_completion=1
	map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
	" python with virtualenv support
py3 << EOF
import os
import sys

if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

	Plugin 'terryma/vim-smooth-scroll'
	noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
	noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
	noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
	noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

	" Track the engine.
	Plugin 'SirVer/ultisnips'

	" Snippets are separated from the engine. Add this if you want them:
	Plugin 'honza/vim-snippets'

	" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumpForwardTrigger="<c-b>"
	let g:UltiSnipsJumpBackwardTrigger="<c-z>"

	" If you want :UltiSnipsEdit to split your window.
	let g:UltiSnipsEditSplit="vertical"

	Plugin 'scrooloose/syntastic'
	Plugin 'nvie/vim-flake8'

	let python_highlight_all=1
	syntax on

	Plugin 'scrooloose/nerdtree'
	Plugin 'jistr/vim-nerdtree-tabs'
	let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
	Plugin 'kien/ctrlp.vim'

	set nu

	Plugin 'tpope/vim-fugitive'

	Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

	Plugin 'vim-scripts/indentpython.vim'

	au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

	set encoding=utf-8

	Plugin 'tpope/vim-projectionist'

	Plugin 'tpope/vim-vinegar' 

" ================================================
" End Plugins
" ================================================
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 softtabstop=2 shiftwidth=2

" ==========================================
" Status Bar Code
" ==========================================

	" Some funky status bar code its seems
	" https://stackoverflow.com/questions/9065941/how-can-i-change-vim-status-line-colour
	set laststatus=2            " set the bottom status bar

	function! ModifiedColor()
		if &mod == 1
			hi statusline guibg=White ctermfg=8 guifg=OrangeRed4 ctermbg=15
		else
			hi statusline guibg=White ctermfg=8 guifg=DarkSlateGray ctermbg=15
		endif
	endfunction

	au InsertLeave,InsertEnter,BufWritePost   * call ModifiedColor()
	" default the statusline when entering Vim
	hi statusline guibg=White ctermfg=8 guifg=DarkSlateGray ctermbg=15

	" Formats the statusline
	set statusline=%f                           " file name
	set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
	set statusline+=%{&ff}] "file format
	set statusline+=%y      "filetype
	set statusline+=%h      "help file flag
	set statusline+=[%{getbufvar(bufnr('%'),'&mod')?'modified':'saved'}]      
	"modified flag

	set statusline+=%r      "read only flag

	set statusline+=\ %=                        " align left
	set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
	set statusline+=\ Col:%c                    " current column
	set statusline+=\ Buf:%n                    " Buffer number
	set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor

" ==========================================
" End Status Bar Code
" ==========================================

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
