set nocompatible
set hidden
set encoding=utf-8
set nu
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" On-demand loading
Plug 'scrooloose/nerdtree'
nnoremap <C-g> :NERDTreeToggle<CR>
nnoremap <silent> <C-r> :Ag<CR>

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
nnoremap <silent> <C-f> :Files<CR>

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='dark'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%3p%% %5l:%3v'])

Plug 'voldikss/vim-floaterm'
nnoremap   <silent>   <F7>    :FloatermNew<CR>

"Plug 'puremourning/vimspector'

Plug 'vim-ctrlspace/vim-ctrlspace'
let g:CtrlSpaceDefaultMappingKey = "<C-space> "

Plug 'dense-analysis/ale'
let g:ale_linters = { 'python': ['pylint']}
let g:ale_warn_about_trailing_whitespace = 0

Plug 'valloric/youcompleteme'

Plug 'edkolev/tmuxline.vim'

" Initialize plugin system
call plug#end()

autocmd BufRead,BufNewFile *.py let python_highlight_all=1
syntax on

" folding
set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf

set splitbelow
set splitright
inoremap <C-t>     <Esc>:tabnew<CR>
nnoremap <C-t>     :tabnew<CR>
nmap <C-S><Down> <C-W><C-J>
nmap <C-S><Up> <C-W><C-K>
nmap <C-S><Right> <C-W><C-L>
nmap <C-S><Left> <C-W><C-H>
imap <C-S><End> <C-W><C-J>
imap <C-S><Home> <C-W><C-K>
imap <C-S><Delete> <C-W><C-L>
imap <C-S><PageDown> <C-W><C-H>
nmap - <C-W>-
nmap + <C-W>+
xnoremap p pgvy
