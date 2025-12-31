nnoremap <space>pv :Vex<CR>
nmap J 5gj
nmap K 5gk
nnoremap <space>/ :nohlsearch<CR>
nmap j gj
nmap k gk

" Visual mode move lines up down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv 

" Copy and pasting utilities
vnoremap <space>p "_dP
vnoremap <space>y "+y
nnoremap <space>y "+y

" Source file
nnoremap <space><CR> :so %<CR>

