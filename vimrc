"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" vimrc - Jorge E. Gomez - jorge@jorgee.net
"-----------------------------------------------------------------------------
" Lots of ideas taken from :
"   Bram Moolenaar <Bram@vim.org>
"   Damian Conway <damian@conway.org>
"   Tsung-Hsiang (Sean) Chang <vgod@vgod.tw>
"-----------------------------------------------------------------------------
" Uses Pathogen to load plugins
"   http://www.vim.org/scripts/script.php?script_id=2332
" Uses Solarized color scheme
"   http://ethanschoonover.com/solarized
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Use the Pathogen plugin manager (https://github.com/tpope/vim-pathogen)
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
call pathogen#infect()
call pathogen#helptags()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let mapleader=","      " change leader key to ,
let maplocalleader="," " change local leader key to ,

if has("vms")
    set nobackup	  " do not keep a backup file, use versions instead
else
    set backup	      " keep a backup file
endif
set history=50		  " keep 50 lines of command line history
set ruler             " show the cursor position all the time
set relativenumber    " Show line numbers offset from current one
set number            " Show current line number
set noshowcmd		  " display incomplete commands
set incsearch		  " do incremental searching
set foldlevelstart=99 " Don't start with folds collapsed

" Indentation (other settings are on vim-sensible)
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" use Blowfish for encryption
if v:version >= 704
  set cryptmethod=blowfish2
else
  set cryptmethod=blowfish
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" Use only one dir for backups and swap files
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//,/tmp//
if v:version >= 703
  set undodir=$HOME/.vim/swap//,/tmp//
endif

" Enable the mouse
"setlocal mouse=a
set mouse=a
set ttymouse=xterm2
set term=xterm

" http://askubuntu.com/questions/67/how-do-i-enable-full-color-support-in-vim
"if $COLORTERM == 'gnome-terminal'
    "set t_Co=256
    "colorscheme solarized
"endif

"if $TERM == 'screen-256color'
    "set t_Co=256
    "colorscheme solarized
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    " set t_Co=16
    syntax enable
    set background=dark
    set hlsearch
    colorscheme solarized
    set guifont=Inconsolata\ Medium\ 16
endif

if has("viminfo")
    " Remember information from previous Vim sessions
    " '20    -> marks for last 20 files are saved
    " no `f<value>' -> all marks are saved
    " "100   -> max lines for each register
    " :20    -> 20 items of cmd-line history are saved
    " /5     -> 5 items of search-pattern-history are saved
    " `h'    -> disable effect of 'hlsearch'
    " no `@' -> 'history' items of input-line history are saved
    " `%'    -> buffer list is saved and restored if Vim is called w/o args
    set viminfo='1,\"100,h,%,:20,/20
endif

if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent
    " indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " When editing a file, always jump to the last known cursor
        " position, except when the position is invalid or when inside
        " an event handler (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif

    augroup END

    " When vimrc is edited, reload it
    autocmd! bufwritepost vimrc source ~/.vimrc
endif

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" File match similar to bash style
"-----------------------------------------------------------------------------
" Can also add 'full', in order for third and subsequent TABs to cycle through
" completion options
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set wildmode=longest,list
set wildmenu

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" vimwiki settings
"-----------------------------------------------------------------------------
" Set up three wikis:
" 1. General wiki 2. Journal-style blog 3. One page password list (encrypted)
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:vimwiki_list = [{ 'path':'~/wiki',
    \ 'path_html':'~/wiki/html/',
    \ 'diary_rel_path': 'log/',
    \ 'diary_header': 'Journal',
    \ 'template_path': '~/wiki/html/assets/templates',
    \ 'template_default': 'default',
    \ 'template_ext': '.tpl',
    \ 'css_name': 'assets/css/main.css',
    \ 'list_margin': 0 },
    \ { 'path':'~/blog',
    \ 'path_html':'/dev/null',
    \ 'index': 'diary',
    \ 'diary_rel_path': '',
    \ 'diary_header': 'Blog',
    \ 'syntax': 'markdown',
    \ 'ext': '.md',
    \ 'list_margin': 0 },
    \ { 'path':'~/wiki',
    \ 'index': 'encrypted_passwords',
    \ 'path_html':'/dev/null',
    \ 'diary_rel_path': '',
    \ 'list_margin': 0 }]
let g:vimwiki_folding = 'syntax'
" Disable Tab on insert mode (conflicts with UltiSnips)
let g:vimwiki_table_mappings = 0

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" vim-markdown settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:vim_markdown_folding_disabled=1

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Keybindings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Insert timestamp
nmap <F3> a<C-R>=strftime("%FT%T%z")<CR><Esc>
imap <F3> <C-R>=strftime("%FT%T%z")<CR>

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" vim-airline
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_theme = 'solarized'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" securemodelines
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:secure_modelines_allowed_items = [
    \ "textwidth", "tw",
    \ "softtabstop", "sts",
    \ "tabstop", "ts",
    \ "shiftwidth", "sw",
    \ "expandtab", "et", "noexpandtab", "noet",
    \ "filetype", "ft",
    \ "foldclose", "fcl",
    \ "foldmethod", "fdm",
    \ "foldlevel",
    \ "foldlevelstart", "fdls",
    \ "swapfile", "swf",
    \ "noswapfile", "noswf",
    \ "bufhidden", "bh",
    \ "backup", "bk", "nobackup", "nobk",
    \ "writebackup", "wb", "nowritebackup", "nowb",
    \ "readonly", "ro", "noreadonly", "noro",
    \ "rightleft", "rl", "norightleft", "norl",
    \ "cindent", "cin", "nocindent", "nocin",
    \ "smartindent", "si", "nosmartindent", "nosi",
    \ "autoindent", "ai", "noautoindent", "noai",
    \ "spell",
    \ "spelllang"
    \ ]
