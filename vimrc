" Be vim, don't pretend to be vi. Setting early as it has side effects.
set nocompatible


""""""""""""""""""
" Vundle
" https://github.com/VundleVim/Vundle.vim
filetype on " Required so vi on OS X doesn't exit with an exit code of 1
filetype off " Required for Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Define bundles via Github repos
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'christoomey/vim-run-interactive'
Plugin 'danro/rename.vim'
Plugin 'reedes/vim-pencil'
Plugin 'kana/vim-textobj-user'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'mxw/vim-jsx'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'pangloss/vim-javascript'
Plugin 'pbrisbin/vim-mkdir'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'slim-template/vim-slim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/ctags.vim'
Plugin 'vim-scripts/fountain.vim'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/tComment'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'kballard/vim-swift'
Plugin 'junegunn/vim-easy-align'
call vundle#end()
filetype plugin indent on


""""""""""""""""""
" Global variables
set autowrite       " Automatically :write before running commands
set background=dark
set backspace=2     " Backspace deletes like most programs in insert mode
set nobackup
set colorcolumn=+1
set expandtab
set history=50
set incsearch       " highlight while searching
set laststatus=2   " Always display the status line
set list listchars=tab:»·,trail:· " Display extra whitespace
set number          " Show line numbers
set numberwidth=4   " Make room for up to 4 digits
set ruler           " show the cursor position all the time
set shiftwidth=2
set shiftround
set showcmd         " display incomplete commands
set splitbelow      " Open new horizontal split panes below current one
set splitright      " Open new vertical split panes to right of the current one
set noswapfile
set tabstop=2       " Softtabs, 2 spaces
set textwidth=80    " Make it obvious where 80 characters is
set nowritebackup
set foldlevelstart=99 " Start with nothing folded

silent! colorscheme solarized


""""""""""""""""""
" Key mappings
let mapleader = " " "Leader

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'


""""""""""""""""""
" Ctags
" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"


""""""""""""""""""
" vim-pencil
let g:pencil#conceallevel = 0 " Don't hide things


""""""""""""""""""
" vim-pandoc
" do syntax highlighting for these languages
let g:pandoc#syntax#codeblocks#embeds#langs = ['javascript', 'ruby', 'sh', 'yaml', 'javascript', 'html', 'vim', 'coffee', 'json', 'diff']
" do no folding by default
let g:pandoc#folding#level = 99


""""""""""""""""
" Syntastic
let g:syntastic_check_on_open=0 " don't check syntax on open (it's slow)
let g:syntastic_check_on_wq = 0 " don't check syntax on quit (who cares?)
" only check on save
" ignore angular-specific attributes
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" Treat js files as React files (for the sake of Ponton)
let g:jsx_ext_required = 0
" use ruby interpreter and rubocop to check ruby syntax
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
" Use Swift defaults
let g:syntastic_swift_swiftlint_use_defaults = 1
let g:syntastic_swift_checkers = ['swiftlint', 'swiftpm']

""""""""""""""""
" Git-gutter
let g:gitgutter_realtime = 500 " Update git gutter more quickly
let g:gitgutter_sign_column_always = 1
let g:gitgutter_highlight_lines = 0


"""""""""""""""""
" Contol-P
let g:ctrlp_working_path_mode = 'r' " start from repo or current dir



"""""""""""""""""
" Silver Searcher
" https://github.com/ggreer/the_silver_searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor " Use in place of grep
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


"""""""""""""""""
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>


augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

augroup filetypes
  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.fountain set filetype=fountain

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for text files
  autocmd FileType markdown,fountain setlocal textwidth=80

  " Strip trailing whitespace
  autocmd FileType c,cpp,java,php,ruby,javascript autocmd BufWritePre <buffer> %s/\s\+$//e
augroup END

augroup pencil
  autocmd!
  autocmd FileType pandoc call pencil#init()
  autocmd FileType markdown call pencil#init()
  autocmd FileType text call pencil#init()
  autocmd FileType fountain call pencil#init({'wrap': 'soft'})
augroup END

augroup autosave
  " Auto save when leaving buffer
  autocmd BufLeave,FocusLost * silent! wall
augroup END

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
