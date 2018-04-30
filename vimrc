"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" vimrc - Jorge E. Gomez - jorge@jorgee.net
"-----------------------------------------------------------------------------
" Lots of ideas taken from :
"   Bram Moolenaar <Bram@vim.org>
"   Damian Conway <damian@conway.org>
"   Tsung-Hsiang (Sean) Chang <vgod@vgod.tw>
"-----------------------------------------------------------------------------
" Uses Vundle to manage plugins
"   https://github.com/VundleVim/
" Uses Solarized color scheme
"   http://ethanschoonover.com/solarized
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Use the Vundle plugin manager
" (https://github.com/VundleVim/Vundle.vim#quick-start)
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Load plugins with Vundle
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" LiteDFM: A lightweight plugin to remove distractions
Plugin 'bilalq/lite-dfm'
Plugin 'plasticboy/vim-markdown'
Plugin 'ciaranm/securemodelines'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-vinegar'
" Taskwiki - Taskwarrior in vim
Plugin 'tbabej/taskwiki'
Plugin 'powerman/vim-plugin-AnsiEsc'
Plugin 'majutsushi/tagbar'
Plugin 'farseer90718/vim-taskwarrior'
" Ranger file manager integration
Plugin 'rafaqz/ranger.vim'
"Plugin 'nathangrigg/vim-beancount'
"Plugin 'junegunn/vim-easy-align'

" all of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"-----------------------------------------------------------------------------

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
if v:version == 704 && has('patch399') || v:version > 704
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

    " When a swap file exists, open the file in read-only mode
    " autocmd SwapExists * let v:swapchoice = "o"

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
" Keybindings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Insert timestamp
nmap <F3> a<C-R>=strftime("%FT%T%z")<CR><Esc>
imap <F3> <C-R>=strftime("%FT%T%z")<CR>

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

"=============================================================================
" Plugin settings
"=============================================================================

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" vimwiki
"-----------------------------------------------------------------------------
" 1. General knowledge-base wiki and log
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let wiki_1 = {}
let wiki_1.path = '~/wiki'
let wiki_1.path_html = '~/wiki/html/'
let wiki_1.diary_rel_path = 'log/'
let wiki_1.diary_header = 'Journal'
let wiki_1.template_path = '~/wiki/html/assets/templates'
let wiki_1.template_default = 'default'
let wiki_1.template_ext = '.tpl'
let wiki_1.css_name = 'assets/css/main.css'
let wiki_1.list_margin = 0

" 2. Markdown blog with the journal page as front
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let wiki_2 = {}
let wiki_2.path = '~/blog'
let wiki_2.path_html = '/dev/null'
let wiki_2.css_name = 'assets/css/main.css'
let wiki_2.index = 'diary'
let wiki_2.diary_rel_path = ''
let wiki_2.diary_header = 'Blog'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'
let wiki_2.list_margin = 0

" 3. Encrypted front page for a password vault
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let wiki_3 = {}
let wiki_3.path = '~/wiki'
let wiki_3.index = 'encrypted_passwords'
let wiki_3.path_html = '/dev/null'
let wiki_3.css_name = 'assets/css/main.css'
let wiki_3.diary_rel_path = ''
let wiki_3.list_margin = 0

let g:vimwiki_list = [wiki_1, wiki_2, wiki_3]
let g:vimwiki_folding = 'syntax'
" Disable Tab on insert mode (conflicts with UltiSnips)
let g:vimwiki_table_mappings = 0

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" taskwiki
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set concealcursor=
let g:taskwiki_disable_concealcursor = 1

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" vim-markdown
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:vim_markdown_folding_disabled = 1

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" LiteDFM
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nnoremap <Leader>z :LiteDFMToggle<CR>:silent !tmux set status > /dev/null 2>&1<CR>:redraw!<CR>

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

" Enable/disable displaying tab number in tabs mode.
let g:airline#extensions#tabline#show_tab_nr = 1

let g:airline#extensions#tabline#tab_nr_type = 1

" Enable/disable displaying tab type (far right) >
let g:airline#extensions#tabline#show_tab_type = 1

" Rename label for buffers (default: 'buffers') (c)
let g:airline#extensions#tabline#buffers_label = 'b'

" Rename label for tabs (default: 'tabs') (c)
let g:airline#extensions#tabline#tabs_label = 't'

" Enable/disable displaying index of the buffer.
" When enabled, numbers will be displayed in the tabline and mappings will be
" exposed to allow you to select a buffer directly.  Up to 9 mappings will be
" exposed.

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" Configure whether close button should be shown:
let g:airline#extensions#tabline#show_close_button = 0

let g:airline#extensions#tabline#show_splits = 0

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" beancount
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"let g:beancount_separator_col = 90
"let b:beancount_root = "main.beancount"
"nnoremap <buffer> <leader>= :AlignCommodity<CR>
"vnoremap <buffer> <leader>= :AlignCommodity<CR>

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

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" easy-align
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ranger.vim
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
map <leader>rr :RangerEdit<cr>
map <leader>rv :RangerVSplit<cr>
map <leader>rs :RangerSplit<cr>
map <leader>rt :RangerTab<cr>
map <leader>ri :RangerInsert<cr>
map <leader>ra :RangerAppend<cr>
map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@

