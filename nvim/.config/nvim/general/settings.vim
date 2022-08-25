syntax on
filetype plugin indent on
set path+=**
" Disable output, vcs, archive, rails, temp and backup files.
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*
set wildignore+=**/node_modules/**
set completeopt=menuone,noselect
set regexpengine=1
set hidden                               " Required to keep multiple buffers open multiple buffers
set relativenumber
set nowrap                               " Display long lines as just one line
set encoding=utf-8                       " The encoding displayed
set fileencoding=utf-8
set pumheight=10
set ruler              			             " Show the cursor position all the time
set iskeyword+=-                      	 " treat dash separated words as a word text object"
set mouse=a                              " Enable your mouse
set splitbelow                           " Horizontal splits will automatically be below
set t_Co=256                             " Support 256 colors
set conceallevel=0                       " So that I can see `` in markdown files
set tabstop=2                            " Insert 2 spaces for a tab set shiftwidth=2                        
set shiftwidth=2
set smarttab                             " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                            " Converts tabs to spaces
set smartindent                          " Makes indenting smart
set autoindent                           " Good auto indent
set number                               " Line numbers
set background=dark                      " tell vim what the background color looks like
set showtabline=2                        " Always show tabs
set noshowmode                           " We don't need to see things like -- INSERT -- anymore
set nobackup                             " This is recommended by coc
set nowritebackup                        " This is recommended by coc
set updatetime=50                        " Faster completion
set timeoutlen=500                       " By default timeoutlen is 1000 ms
set clipboard+=unnamedplus               " Copy paste between vim and everything else
set noswapfile
set undodir=~/.vim/undodir
set undofile
set scrolloff=10
set guicursor=n-v-c:block-Cursor
set incsearch
set colorcolumn=80
set termguicolors
set shortmess+=A                        " This is needed to avoid swapfile warning when auto-reloading
set shortmess+=c
set shortmess-=F
set ignorecase                          " Ignore case when searching.
set smartcase
set nocursorline                        " Don't paint cursor line
set nocursorcolumn                      " Don't paint cursor column
" Live update substitution
set inccommand=nosplit
" Decimal inc/dec on c-a and c-x
set nrformats=
set lazyredraw

" START - Testing some settings
set breakindent
set breakindentopt=shift:2
set showbreak=+++++
set showbreak=↳
" END - Testing some settings
"
let mapleader=" "

let g:cursorhold_updatetime = 100

" netrw configs
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 0
let g:netrw_winsize = 15
let g:netrw_banner=0
let g:term_buf = 0
let g:NetrwIsOpen=0

let g:fugitive_summary_format = "%s <%an>"

"projects
let g:nvim_tree_update_cwd = 1
let g:nvim_tree_respect_buf_cwd = 1

" markdown
let g:mkdp_auto_close = 0

" vim-test
let test#strategy = 'neovim'
let test#neovim#term_position = "vert botright 70"
let test#javascript#jest#options = "--color=always"

let g:ultest_use_pty = 1
let g:ultest_pass_sign = "👌"
let g:ultest_fail_sign = "💩"
let g:ultest_running_sign = '🚀'
let g:ultest_deprecation_notice = 0

let g:asyncrun_open = 8

command! -bar -bang -nargs=+ -complete=file Edit call MultipleEdit([<f-args>])
