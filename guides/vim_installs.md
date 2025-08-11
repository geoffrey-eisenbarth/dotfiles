mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
git clone https://github.com/dense-analysis/ale
git clone https://github.com/vim-airline/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes
git clone https://github.com/nvie/vim-flake8.git
git clone git://github.com/ntpeters/vim-better-whitespace.git
git clone https://github.com/jasonshell/vim-svg-indent.git
git clone https://github.com/integralist/vim-mypy
