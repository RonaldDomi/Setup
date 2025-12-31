set scrolloff=8
set relativenumber
set number
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set incsearch

let mapleader = " "

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'BurntSushi/ripgrep'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'

call plug#end()

nnoremap <leader>pv :Vex<CR>
nnoremap J 5j<CR>
nnoremap K 5k<CR>
nnoremap <leader>/ :nohlsearch<CR>

" FZF
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>

" Visual mode move lines up down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv 

" Copy and pasting utilities
vnoremap <leader>p "_dP
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" Source file
nnoremap <leader><CR> :so %<CR>


" File type detection
filetype plugin indent on
syntax enable
