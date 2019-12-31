"""""""""""""""""""""""""""""""""vim-plug
"https://raw.githubusrcontent.com/junegunn/vim-plug/master/plug.vim put it into .vim/autoload/"
if has("win32")
call plug#begin('~/vimfile/plugged')  "vim install folder
else
call plug#begin('~/.vim/plugged')   "user diretory
endif
"Build symbol index
Plug 'universal-ctags/ctags'
Plug 'ludovicchabant/vim-gutentags'
"Syntax highlight
Plug 'octol/vim-cpp-enhanced-highlight'
"Compile and run
Plug 'skywind3000/asyncrun.vim'
"Dynamic syntax checking
Plug 'dense-analysis/ale'
"Compare and Modify
Plug 'mhinz/vim-signify'
"Text alignment
Plug 'junegunn/vim-easy-align'
"Quick insert code section
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"Suite for text object
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', {'for':['c','cpp','vim','java']}
Plug 'sgur/vim-textobj-parameter'
"Code complete
Plug 'ycm-core/YouCompleteMe',{'do':'./install.py --clang-completer'}
"Function name list and text switch
Plug 'Yggdroot/LeaderF',{'do':'./install.sh'}
"Hint for argument
Plug 'Shougo/echodoc.vim'
"File explorer
Plug 'vim-scripts/a.vim'
Plug 'justinmk/vim-dirvish'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
call plug#end()
"gutentags setting
"gutentags keyword for search the directory, stop and recursive upward when
"hitting these words
let g:gutentags_project_root = ['.root','.svn','.git','.project']
"index file's name'
let g:gutentags_ctags_tagfile = '.tags'
"Put the tags file into ~/.cache/tags', so that it won't pollute the workspace
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
"if ~/.cache/tags is not exist, create one
if !isdirectory(s:vim_tags)
silent!call mkdir(s:vim_tags,'p')
endif
"ctags setting
let g:gutentags_ctags_extra_args = ['--fields=+niazS','--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"compile setting
"turn on quickfix_window, height = 6
let g:asyncrun_open = 6
"Alarm when task finished
let g:asyncrun_bell = 1
"F3 is the hotkey for turn on/off Quickfix
nnoremap <F3>:call asyncrun#quickfix_toggle(6)<cr>
"compile single file
nnoremap <silent> <F9>:AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"<cr>
"run
nnoremap <silent> <F5>:AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"<cr>
"searching rootmarks setting
let g:asyncrun_rootmarks = ['.svn','.git','.root','.project','_darcs','build.xml']
"compile the whold project
nnoremap <silent> <F7>:AsyncRun -cwd=<root> make <cr>
"Run project
nnoremap <silent> <F8>:AsyncRun -cwd=<root> -raw make run <cr>
"Dynamic checking setting
let g:ale_linters_explicit = 1
let g:ale_linters = {
\  'csh': ['shell'],
\  'zsh': ['shell'],
\  'go': ['gofmt','golint'],
\  'python': ['flake8','mypy','pylint'],
\  'c': ['gcc','cppcheck'],
\  'cpp':['gcc','cppcheck'],
\  'text':[],
\}
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_fotmat = '[%linter%]%code:%%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
let g:ale_cpp_cppcheck_options = ''
let g:ale_c_cppcheck_options = ''
"let g:ale_linters_explicit = 1
hi!clear SpellBad
hi!clear SpellCap
hi!clear SpellRare
hi!SpellBad gui=undercurl guisp=red
hi!SpellCap gui=undercurl guisp=blue
hi!SpellRare gui=undercurl guisp=magenta
"argument hint
set noshowmode
"Code complete
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_commets_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_confirm_Extra_conf = 0
let g:ycm_key_invoke_completion = '<c-z>'
noremap <c-z> <NOP>
set completeopt=menu,menuone
let g:ycm_semantic_triggers = {
\ 'c,cpp,python,java,go,erlang,perl':['re!\w{2}'],
\ 'cs,lua,javascript':['re!w{2}'],
\ }
"highlight color setting
highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black
"for the following appointed file, trigger when type 2 letters
let g:ycm_semantic_triggers = {
\ 'c,cpp,python,java,go,erlang,perl':['re!W{2}'],
\ 'cs,lua,javascript':['re!\W{2}'],
\ }
let g:ycm_filetype_whitelist = {
\ "c":1,
\ "cpp":1,
\ "go":1,
\ "python":1,
\ "sh":1,
\ "zsh":1,
\ }
let g:ycm_filetype_blacklist = {
\ 'markdown' : 1,
\ 'text' : 1,
\ 'pandoc' : 1,
\ 'infolog' : 1,
\ }
"Function list and text switch
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <c-n> :LeaderfMru<cr>
noremap <m-p> :LeaderfFunction!<cr>
noremap <m-n> :LeaderfBuffer<cr>
noremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = {'left':'','right':'','font':''}
let g:Lf_RootMarkers = ['.project','.root','.svn','.git']
let g_Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0,'BufTag':0}
""""""""""""""""""""""""""""""""""""""plug
filetype on
"Turnoff auto backup
set noundofile
set nobackup
set noswapfile
"Text encoding
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
set fileencodeing=chinese
else
set fileencoding=utf-8
endif
"auto compelte of c and non-c file comment
:autocmd FileType * set formatoptions=tcql
\ nocindent comments&
:autocmd FIleTYpe c,cpp set formatoptions=croql
\ cindent comments=sr:/*,mb:*,ex:*/,://
"Autoload template with file posfix
"&VIM is the vim installation path, /usr/share/vim/ in linux
"put the template file to be used into $VIM/template
:autocmd BufNewFile *.c          0r $HOME/.vim/template/skeleton.c
:autocmd BufNewFile *.cpp          0r $HOME/.vim/template/skeleton.cpp
:autocmd BufNewFile *.go          0r $HOME/.vim/template/skeleton.go
"set cindent                  "auto indent with 4 space
"Fix the messy code in vim menu
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim
"Fix the messy code in vim hint info
language messages zh_CN.utf-8
if has("win32")
set termencoding=chinese
language message zh_CN.utf-8
endif
set smartindent
set shortmess=atI  "remove the welcome page
colorscheme desert  "sublime scheme
if has("win32")
set guifont=lucida\ Console:h14:w7  "font and size
endif
if has("gui_gtk2")
set guifont=Monospace\ 14  "font and size
endif
set expandtab               "replace tab to space. if need to insert a tab in the beginning, it should be use CTRL-V<Tab> in insert mode
set shiftwidth=4            "line break with 4 space interleavely
set backspace=2             "backspace is viable
set autoindent              "autoindent
set smartindent             "smartindent
set number                  "show line number
set mouse=a                 "enable mouse
set ruler                   "show the cusor pos status bar in the right-bottom conner
set hlsearch                "highlight the serch result
if has("gui_running")
" set incsearch           "turn on live search, only for gvim
endif
set nowrapscan               "don't scan again when wrapping
set nocompatible             "turn off the compatible mode
set vb t_vb=                 "turn off the hint sound
au GuiEnter * set t_vb=      "turn off the flash
set hidden                   "Enable switching buffer when modification is not saved
set list                     "show tab
set listchars=tab:\|\        "using a highlighted | to show tab
set background=dark          "backgroud is dark
set showcmd                  "show incompleted cmd
set fileformats=unix,dos     "prefer unix format when saving a file
set fileformat=unix          "sava file as unix format
set endofline                "show <EOL> at the end
syntax enable                "highlight the syntax
syntax on                    "turn on file type detection
filetype indent on           "using different indent for different filetype
filetype plugin on           "using different plug with different filetype
filetype plugin indent on    "turn on autoindent
"Maximize the window
"gui_gtk2 means 'is system running a gtk GUI'
"gui_running means 'is gui running'
if has("win32")
autocmd GUIEnter * simalt ~x
else
if has("gui_running")
"GUI is running or is about to start.
"Maximize gvim window (for an alternative on Windows, see simalt
"below)
set lines=999 columns=200
else
"This is console Vim.
"If exist("+lines")
"    set lines=50
"endif
"if exists("+columns")
"    set columns=100
"endif
endi
endif
"setting for window, all marked
"source $VIMRUNTIME/vimrc_example.vim
"set diffexpr=MyDiff()
"function MyDiff()
"    let opt = '-a --binary'
"    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"    let arg1 = v:fname_in
"    if arg1 =~ ' ' | let arg1= '"' . arg1 . '"' | endif
"    let arg1 = substitute(arg1, '!','\!','g')
"    let arg2 = v:fname_new
"    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"    let arg2 = substitute(arg1, '!','\!','g')
