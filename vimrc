filetype plugin on
set hidden
set autochdir
set mouse=n
set modeline
set timeoutlen=1000 ttimeoutlen=10

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1

map <C-n> :NERDTreeToggle<CR>

Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'

let g:go_version_warning = 0
Plug 'fatih/vim-go'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'

Plug 'editorconfig/editorconfig-vim'

" Plug 'neomake/neomake'
Plug 'milkypostman/vim-togglelist'

if executable('racer')
    let g:racer_experimental_completer = 1
    let g:racer_insert_paren = 1
    Plug 'racer-rust/vim-racer'
endif

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
elseif has('python3')
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

call plug#end()

" call neomake#configure#automake('nrwi', 500)

nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" inoremap <Esc> <nop>
inoremap jj <Esc>
nnoremap n nzz
nnoremap } }zz

set scrolloff=10

nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

set tabstop=4 shiftwidth=4 expandtab
set nu rnu
let mapleader = ','
