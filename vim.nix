{ pkgs, ... }:
{
  enable = true;
  plugins = with pkgs.vimPlugins; [
    vim-sensible
    vim-airline
    vim-airline-themes
    syntastic
    nerdtree
    nerdcommenter
    editorconfig-vim
    vim-surround
    ctrlp-vim

    vim-fugitive
    vim-gitgutter

    rust-vim
    vim-go
    vim-javascript
    typescript-vim
    tsuquyomi
    vim-nix
    vim-elixir
    vim-toml
    # vim-mix-format

    deoplete-nvim
    nvim-yarp
    # vim-hug-neovim-rpc
  ];

  settings = {
    tabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    background = "dark";
    smartcase = true;
  };

  extraConfig = ''
    set nu rnu
    set scrolloff=10

    set hidden
    set autochdir
    set mouse=n
    set modeline
    set timeoutlen=1000 ttimeoutlen=10

    let mapleader = ','

    nnoremap <Up> <nop>
    nnoremap <Down> <nop>
    nnoremap <Left> <nop>
    nnoremap <Right> <nop>

    " inoremap <Esc> <nop>
    inoremap jj <Esc>
    nnoremap n nzz
    nnoremap } }zz

    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

    nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

    " let g:deoplete#enable_at_startup = 1

    " let g:mix_format_on_save = 1
    " let g:mix_format_silent_errors = 1

    let g:rustfmt_autosave = 1
    let g:rust_clip_command = 'xclip -selection clipboard'

    let g:go_version_warning = 0

    let g:NERDSpaceDelims = 1
    map <C-n> :NERDTreeToggle<CR>
  '';
}
