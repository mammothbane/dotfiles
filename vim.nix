{ pkgs }:

{
  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; with pkgs.customVimPlugins; [
      vim-sensible
      vim-airline
      vim-airline-themes
      syntastic
      nerdtree
      nerdcommenter
      editorconfig-vim
      vim-surround
      ctrlp-vim
      vim-unimpaired
      vim-mundo

      darcula

      vim-fugitive
      vim-gitgutter

      rust-vim
      vim-go
      kotlin-vim
      julia-vim

      haskell-vim
      vim-hindent
      stylish-haskell

      vim-javascript
      typescript-vim
      tsuquyomi

      vim-elixir
      alchemist-vim
      vim-mix-format

      vim-nix
      vim-toml
      vim-terraform

      ncm2
      nvim-yarp
      ncm2-jedi
      ncm2-tmux
      ncm2-go
      ncm2-racer
      # ncm2-alchemist
      ncm2-vim
      ncm2-pyclang
      ncm2-tern
      # ncm2-typescript
      ncm2-path

      LanguageClient-neovim

      deoplete-nvim
    ];

    extraConfig = ''
      set nu rnu
      set scrolloff=10

      set tabstop=4
      set shiftwidth=4

      set expandtab
      set smartcase

      set background=dark
      colorscheme darcula

      set cursorline
      hi CursorLine     cterm=NONE ctermbg=234
      hi CursorColumn   cterm=NONE ctermbg=234

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

      autocmd BufEnter * call ncm2#enable_for_buffer()
      set completeopt=noinsert,menuone,noselect

      "    let g:deoplete#enable_at_startup = 1
      "    call deoplete#custom#option({
      "    \ 'auto_complete_delay': 100,
      "    \ 'smart_case': v:true,
      "    \})

      set shortmess+=c

      let g:mix_format_on_save = 1
      let g:mix_format_silent_errors = 1

      let g:rustfmt_autosave = 1
      let g:rust_clip_command = 'xclip -selection clipboard'

      let g:go_version_warning = 0

      let g:NERDSpaceDelims = 1
      map <silent> <C-n> :NERDTreeToggle<CR>

      set undofile
      set undodir=~/.cache/vim/undo
    '';
  };
}
