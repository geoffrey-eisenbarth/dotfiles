" must install pathogen and plugins manually!
" mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso
" ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"
" cd ~/.vim/bundle
" git clone https://github.com/dense-analysis/ale.git
" git clone https://github.com/vim-airline/vim-airline.git
" git clone https://github.com/vim-airline/vim-airline-themes.git
" git clone https://github.com/nvie/vim-flake8.git
" git clone https://github.com/ntpeters/vim-better-whitespace.git
" git clone https://github.com/jasonshell/vim-svg-indent.git
"
" vim changed all their colorschemes in 9.0 to get the old / broken
" ones, use the following:
" https://github.com/romainl/vim-legacy-colorschemes.git
"
" had to run `npm init @esling/config` to get eslint working


execute pathogen#infect()

" set laststatus=2
set title

" set line numbers
set number

" syntax coloring
syntax on
colorscheme elflord

" easy navigation of window splits
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :windcmd l<CR>

" mouse mode
set mouse=a

" set code folding by indent. <za> toggles
set foldmethod=indent
set foldnestmax=8

" needed for vim-flake8 to run
filetype plugin on

" disable filetype-based indentention settings
filetype indent off

" disable bell
set visualbell

" set tab/spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" override /usr/share/vim/vim90/ftplugin/markdown.vim
"autocmd FileType markdown setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
" override /usr/share/vim/vim90/ftplugin/python.vim
"autocmd FileType python setlocal noexpandtab tabstop=2 softtabstop=2 shiftwidth=2

" reveal tabs (when ":set list" is used)
" set list
set listchars=tab:»-,space:·

" use powerline fonts
let g:airline_powerline_fonts = 1

" specify JS linters
let g:ale_linters = {
\  'javascript': ['prettier', 'eslint'],
\  'python': ['pylint'],
\}
"let g:ale_open_list = 1

" fix and format JS on save
let g:ale_fixers = {
\  'javascript': ['prettier', 'eslint'],
\}
let g:ale_sign_column_always = 1
"let g:ale_fix_on_save = 1


" Remove SVGs etc from autocomplete
setglobal complete-=i

" Allow 2-space indents
set autoindent
set smartindent
