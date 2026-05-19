set scrolloff=8
set relativenumber
set number
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set incsearch
set hlsearch
set laststatus=2
set statusline=%F%m%r%h%w\ 
set belloff=all


set directory=~/tmp//

" =================== NETRW hiding list ===========
let g:netrw_list_hide = 'node_modules'
let g:netrw_list_hide .= ',__pycache__'
let g:netrw_list_hide .= ',\.pyc$,\.pyo$,\.pyd$'
let g:netrw_list_hide .= ',.*\.egg-info/$'
let g:netrw_list_hide .= ',\.eggs/$,build/$,dist/$'
let g:netrw_list_hide .= ',\.git/$'
let g:netrw_list_hide .= ',\.DS_Store$'
let g:netrw_list_hide .= ',dist,build'
let g:netrw_list_hide .= ',package-lock\.json$,yarn\.lock$'
let g:netrw_list_hide .= ',\.coverage$,coverage'
let g:netrw_list_hide .= ',\.pytest_cache'
let g:netrw_list_hide .= ',\.mypy_cache'
let g:netrw_list_hide .= ',\.vscode,\.idea'
let g:netrw_list_hide .= ',\.swp$,\.swo$,.*\.tmp$'



" =================== FOLDING CONFIGURATION ===========
set foldmethod=manual
set foldlevelstart=5
set foldnestmax=10
set foldminlines=1
" Custom fold text for cleaner display
set foldtext=substitute(getline(v:foldstart),'\\t','\ \ \ \ ','g').'\ ...\ '.substitute(getline(v:foldend),'\\t','\ \ \ \ ','g')
set fillchars=fold:\ 

let g:javascript_fold = 1
let g:jsx_fold = 1
let g:typescript_fold = 1


let mapleader = " "

" =================== SETUP FOR PLUGINS ==============

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'BurntSushi/ripgrep'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'joshdick/onedark.vim'

call plug#end()

" =================== SETUP FOR PLUGINS ===============
" =================== SETUP FOR COC.VIM ===============
set hidden
set updatetime=300
set shortmess+=cI
set signcolumn=yes

" Simplified tab completion that respects expandtab
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<C-t>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-d>"

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Formatting selected code
xmap <leader>l <Plug>(coc-format-selected)
nmap <leader>L :call CocAction('format')<CR>

" =================== SETUP FOR COC.VIM ===============
" =================== SETUP FOR FZF + Rigprep =========


if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --no-filename --hidden --glob "!.git/*" --glob "!node_modules/*"'
    set grepprg=rg\ --vimgrep\ --smart-case\ --follow\ --no-filename-header
    set grepformat=%f:%l:%c:%m
endif

let g:fzf_layout = {'down': '~40%'}
let $FZF_DEFAULT_OPTS = '--exact'

function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
endfunction     

let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

" =================== SETUP FOR FZF + Rigprep =========
" =================== FILE FINDING & NAVIGATION =======
nnoremap <C-p> :GFiles<CR>
" find all
nnoremap <leader>fa :Files<CR>
" find search
command! -bang -nargs=* Rg call fzf#vim#grep("rg --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 3..'}, <bang>0)
nnoremap <leader>fs :Rg<CR>
" find word
nnoremap <leader>fw :Rg <C-R>=expand("<cword>")<CR><CR>
" =================== FILE FINDING & NAVIGATION =======
" =================== BUFFER NAVIGATION ===============
" buffer browse + promt
nnoremap <leader>bb :ls<CR>:b<Space> 
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bd :bd<CR>
" buffer find
nnoremap <leader>bf :Buffers<CR>
" =================== BUFFER NAVIGATION ===============
" =================== QUICKFIX NAVIGATION =============
nnoremap <leader>qo :copen<CR>
nnoremap <leader>qc :cclose<CR>
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprevious<CR>
nnoremap <leader>qf :cfirst<CR>
nnoremap <leader>ql :clast<CR>
" =================== QUICKFIX NAVIGATION =============
" =================== WINDOW/SPLIT NAVIGATION =========
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>sv :vsplit<CR><C-w>l:GFiles<CR>
nnoremap <leader>sh :split<CR><C-w>j:GFiles<CR>
nnoremap <leader>sb :vsplit<CR><C-w>l:Buffers<CR>
" =================== SPLIT NAVIGATION ==============
" =================== FOLDING  ==============
" Smart indent folding - toggle fold for indented block (ignore empty lines)
function! ToggleFoldIndentedBlock()
    let current_line = line('.')
    
    " Check if we're already in a fold
    if foldclosed(current_line) != -1
        " We're in a closed fold, open it
        normal! zo
        return
    endif
    
    " Check if current line starts a fold
    if foldlevel(current_line) > 0 && foldclosed(current_line + 1) != -1
        " There's a fold starting here, open it
        normal! zo
        return
    endif
    
    " No existing fold, create one
    let current_indent = indent(current_line)
    let next_line = current_line + 1
    let next_indent = indent(next_line)
    
    " If next line is more indented, fold the block
    if next_indent > current_indent
        let end_line = next_line
        " Find where the indentation returns to current level or less
        " Skip empty lines when checking indentation
        while end_line <= line('$')
            let line_content = getline(end_line)
            " If line is not empty, check its indentation
            if line_content !~ '^\s*$'
                if indent(end_line) <= current_indent
                    break
                endif
            endif
            let end_line += 1
        endwhile
        let end_line -= 1
        
        " Create the fold
        execute current_line . ',' . end_line . 'fold'
    endif
endfunction

nnoremap <leader><leader> :call ToggleFoldIndentedBlock()<CR>
" =================== FOLDING  ==============
" =================== Other =========================
nnoremap J 5j<CR>
nnoremap K 5k<CR>
nnoremap <leader>/ :nohlsearch<CR>

nmap <C-_> gcc
vmap <C-_> gc
imap <C-_> <ESC>gcc

" Visual mode move lines up down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv 

" Copy and pasting utilities
" vnoremap <leader>p "_dP
" vnoremap <leader>y "+y
" nnoremap <leader>p "+p
" nnoremap <leader>P "+P

" Source file
nnoremap <leader><CR> :so %<CR>

" File type detection
filetype plugin indent on
syntax enable

" OneDark color scheme configuration
if (!empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

colorscheme onedark

" Remove gray background from onedark, keep transparent
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight LineNr ctermfg=grey guifg=#5c6370 ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
" =================== Other =========================

" =================== NEXTJS SPECIFIC =================
" Set file types for NextJS files
augroup NextJSFileTypes
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
    autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
    autocmd BufNewFile,BufRead *.ts set filetype=typescript
    autocmd BufNewFile,BufRead *.js set filetype=javascript
augroup END

" =================== PYTHON SPECIFIC =================
" Python-specific settings
augroup PythonSettings
    autocmd!
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
    " autocmd FileType python setlocal textwidth=79
    " autocmd FileType python setlocal colorcolumn=80
augroup END

" Enable Python syntax highlighting
let g:python_highlight_all = 1

" =================== COC hover automatically ===========
function! ConditionalHover()
  if CocHasProvider('hover')
    call CocActionAsync('doHover')
  endif
endfunction
autocmd CursorHold * silent call ConditionalHover()
set updatetime=300
autocmd CursorMoved * silent call coc#float#close_all()

" =================== COC HIGHLIGHT CUSTOMIZATION =====
" Inlay hints styling - onedark has its own color coordination
" highlight CocInlayHint ctermfg=240 guifg=#585858 ctermbg=NONE guibg=NONE
