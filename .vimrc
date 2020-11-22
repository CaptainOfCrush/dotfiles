"--------------------------------vim settings----------------------------------
" This is neccessary for the colorscheme appearantly
filetype off
filetype plugin indent on

set dir=~/tmp,/var/tmp
set backupdir=~/tmp,~/
set undodir=~/tmp,~/

set colorcolumn=132

"set the editor to act like vim rather than vi
set nocompatible

"stop creating those annoying ~ files.
set nobackup

"auto tab and untab when using braces
set smarttab
"set autoindent

"so when you must backspace it deletes the correct character
set backspace=2

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"do incremental searching
set incsearch

"when you are in visual mode and you press > or < it will shift that many spaces
set shiftwidth=4

"display incomplete commands
set showcmd

"keep 50 lines of command line history
set history=50

"show the cursor position all the time
set ruler

"hide the mouse if you are typing
set mousehide

"In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

set ttymouse=sgr

"do not wrap lines around
set nowrap

"necessary to turn tabs into spaces
set tabstop=4
set expandtab

"Search case insensitive
set ignorecase
set smartcase

set vb

set winfixwidth

"set the font
set guifont=DejaVu\ Sans\ Mono\ 11
"set guifont=ProggyCleanTT\ 15
"set guifont=Crisp\ 14

"show line numbers by default
set nonumber

" trailing whitespace will be shoen as +'s
set list lcs=trail:+,tab:\ \ 

" Turn off menubar
set guioptions-=m

" Turn off toolbar
set guioptions-=T

" Turn off scrollbar
set guioptions-=r
set guioptions-=b
set guioptions-=L

set tabpagemax=100

set foldmethod=manual

set clipboard+=unnamed

" Curson setting
highlight Cursor guibg=white guifg=black
highlight iCursor guibg=white guifg=black
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver25-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" How splits behave
" set equalalways

set diffopt+=iwhite
set diffexpr=DiffW()

function! DiffW()
  let opt = ""
   if &diffopt =~ "icase"
     let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
     let opt = opt . "-w " " swapped vim's -b with -w
   endif
   silent execute "!diff -a --binary " . opt .
     \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
endfunction

let s:windows = has("win16") || has("win32") || has("win64")
if s:windows
    let s:tempdir = "C:\\Windows\\temp"
else
    let s:tempdir = "/tmp"
endif

"termdebug window options
let g:termdebug_popup = 0
let g:termdebug_wide = 163

" Pick one
let b:use_eclim = 0
let b:use_ycm = 0
let b:use_rtags = 0
let b:use_coc = 1

" Other options
let b:use_autocomplete = 0
let b:use_supertab = 0
let b:use_gitgutter = 1
let b:use_nvim = 0

" Pick one
let b:use_fzf = 1
let b:use_crtlp = 0

" Vim packages
packadd termdebug

" This is required or used for Vundle
" To install configured bundles, :BundleInstall
" ------------- Vundle -------------------
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'guns/xterm-color-table.vim.git'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/git-time-lapse'
Bundle 'godlygeek/tabular'
"Bundle 'kshenoy/vim-signature'
Bundle 'scrooloose/nerdtree'
if !exists("b:use_coc") && !b:use_coc
    Bundle 'bling/vim-airline'
endif
Bundle 'rking/ag.vim'
Bundle 'xolox/vim-notes'
Bundle 'xolox/vim-misc'
Bundle 'fatih/vim-go'
Bundle 'aklt/plantuml-syntax'
Bundle 'hdima/python-syntax'
Bundle 'mhinz/vim-startify'
Bundle 'chrisbra/Colorizer'
Bundle 'luochen1990/rainbow'

let python_highlight_all = 1

let g:go_fmt_autosave = 0
let g:go_term_mode = "split"
let g:go_term_enabled = 1
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>i  <Plug>(go-install)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

"----------------------------------------
" Fuzzy File Searchers
"----------------------------------------
if exists("b:use_crtlp") && b:use_crtlp
    Bundle 'ctrlpvim/ctrlp.vim'

    "let g:ctrlp_regexp=0
    let g:ctrlp_use_caching=0
    let g:ctrlp_by_filename = 1
    let g:ctrlp_regexp = 1

    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
    if executable('ag')
      let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    endif

    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*

    " CtrlP for opening files
    map <C-p> :CtrlP <Esc>

endif

if exists("b:use_fzf") && b:use_fzf
    Bundle 'junegunn/fzf'
    Bundle 'junegunn/fzf.vim'

    " CtrlP for opening files
    map <C-p> :GFiles <Esc>

endif

"----------------------------------------
"NVIM
"----------------------------------------

if exists("b:use_nvim") && b:use_nvim
    Bundle 'vimlab/split-term.vim'
endif

"----------------------------------------
" Supertab
"----------------------------------------
if exists("b:use_supertab") && b:use_supertab
    Bundle 'ervandew/supertab'
endif

"----------------------------------------
" Basic fuzzy-searching autocomplete
"----------------------------------------
if exists("b:use_autocomplete") && b:use_autocomplete
    Bundle 'vim-scripts/AutoComplPop'

    " SuperTab option for context aware completion
    let g:SuperTabDefaultCompletionType = "context"
    "let g:SuperSetTabDefaultCompletionType = "<c-x><c-u>"
    let g:SuperTabClosePreviewOnPopupClose = 0
endif

"----------------------------------------
" eclim
"----------------------------------------
" NOTE: The eclim plugin is installed via an installer and placed in .vim/
if b:use_eclim == 1
    let g:EclimCompletionMethod = 'omnifunc'
    let g:neocomplcache_force_omni_patterns = []
endif

"----------------------------------------
" Rtags
"----------------------------------------
if exists("b:use_rtags") && b:use_rtags

    " Default bundles and settings for RTags

    Bundle 'lyuts/vim-rtags'
    if has('nvim')
        Bundle 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Bundle 'Shougo/deoplete.nvim'
        Bundle 'roxma/nvim-yarp'
        Bundle 'roxma/vim-hug-neovim-rpc'
    endif
    Bundle 'zchee/deoplete-jedi'
    Bundle 'rzaluska/deoplete-rtags'

    let g:deoplete#enable_at_startup = 1
    let g:deoplete#sources#jedi#show_docstring = 1

    " Add compile_commands.json as an rtags project.
    " Requires RDM to be running and a compile_commands.json file to already exist.
    function! AddRtagsProject()
        let l:compile_commands_path = system("find -wholename \\*/test_obj/compile_commands.json")
        if l:compile_commands_path == ""
            echoerr "Could not find compile_commands.json.  Build unittest for any component to generate it."
        else
            exec "!rc --path-filter=test_obj/ -J " . l:compile_commands_path
        endif
    endfunction

    set completeopt+=preview
endif

"----------------------------------------
" Clang and YouCOmpleteMe
"----------------------------------------
if exists("b:use_ycm") && b:use_ycm

    Bundle 'Rip-Rip/clang_complete'
    Bundle 'Valloric/YouCompleteme'

    " Blacklist setup
    if !exists("g:ycm_filetype_blacklist")
        let g:ycm_filetype_blacklist = {'text': 1, 'xxd': 1, 'notes': 1, 'markdown': 1, 'untie': 1, 'vimwiki': 1, 'tagbar': 1, 'qf': 1}
    endif

    let g:ycm_filetype_blacklist.asm = 1
    let g:ycm_filetype_blacklist.dis = 1
    let g:ycm_filetype_blacklist.etm = 1
    let g:ycm_filetype_blacklist.evdump = 1
    let g:ycm_filetype_blacklist.sym = 1
    let g:ycm_filetype_blacklist.fo = 1

    let g:ycm_confirm_extra_conf = 0
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_show_diagnostics_ui = 0

    " Required to fix YCM errors when executed from commandline in Windows
    if has("win16") || has("win32") || has("win64")
        let g:ycm_server_use_vim_stdout = 0
    endif

    " Enable auto popup
    let g:clang_complete_auto = 0

    " Turn off automatically selecting the first entry in the popup menu
    let g:clang_auto_select =  0
    let g:SuperTabLongestHighlight = 0

    " Show clang errors in the quickfix window
    let g:clang_complete_copen = 1
    let g:clang_hl_errors =1

    let g:clang_snippets=1
    let g:clang_conceal_snippets=1
    let g:clang_complete_snippets = 1

    "The single one that works with clang_complete
    let g:clang_snippets_engine='clang_complete'

    " Remap these so they don't override ctags
    let g:clang_jumpto_declaration_key='<C-S-]>'
    let g:clang_jumpto_back_key='<C-S-T>'

    let g:clang_library_path = "/usr/lib/llvm-3.9/lib"

    au Filetype c,cpp call OnLoadCppFile(s:tempdir)

    let g:EclimCompletionMethod = 'omnifunc'
    let g:EclimCValidate = 0
endif

"----------------------------------------
" coc.nvim
"----------------------------------------
if exists("b:use_coc") && b:use_coc

    call plug#begin('~/.vim/plugged')

    Plug 'neoclide/coc.nvim', {'branch': 'release',  'for': ['cpp', 'python', 'go', 'tcl', 'typescript', 'json']}

     " Really only for the :CclsCallHierarchy and :CclsDerivedHierarchy tool to get nice trees
    Plug 'm-pilia/vim-ccls', {'for': ['cpp', 'python', 'go', 'tcl', 'typescript', 'json']}

     " Used for semantic highlighting
    Plug 'jackguo380/vim-lsp-cxx-highlight', {'for': ['cpp', 'python', 'go', 'tcl', 'typescript', 'json']}

    " Something like tagbar
    Plug 'liuchengxu/vista.vim', {'for': ['cpp', 'python', 'go', 'tcl', 'typescript', 'json']}

    " status line plugin
     Plug 'itchyny/lightline.vim'

     " Mostly plugins to support lightline
"     Plug 'sainnhe/artify.vim'
"     Plug 'itchyny/vim-gitbranch'
"     Plug 'macthecadillac/lightline-gitdiff'
"     Plug 'maximbaz/lightline-ale'
"     Plug 'albertomontesg/lightline-asyncrun'
"     Plug 'rmolin88/pomodoro.vim'

    call plug#end()

    let g:coc_global_extensions = ['coc-json']

"    autocmd BufRead,BufNewFile *.{bz2,txt,etl,etm} :CocDisable
"    autocmd BufRead,BufNewFile *.{bz2,txt,etl,etm} :LspCxxHighlightDisable

    "----------------------------------------------------
    " vim-ccls settings
    let g:yggdrasil_no_default_maps = 1

    " Use <space> to expand/collapse nodes in the trees
    au FileType yggdrasil nmap <silent> <buffer> <space> <Plug>(yggdrasil-toggle-node)

    " Use <cr> to jump to the line
    au FileType yggdrasil nmap <silent> <buffer> <cr> <Plug>(yggdrasil-execute-node)

    let g:ccls_size = 20
    let g:ccls_orientation = 'horizontal'
    let g:ccls_position = 'bot'

    nmap <silent> gh :CclsCallHierarchy<CR>
    nmap <silent> gc :CclsBaseHierarchy<CR>
    nmap <silent> gm :CclsMemberHierarchy<CR>
    " vim-ccls ^
    "----------------------------------------------------
    nn <silent> xc :call CocLocations('ccls','$ccls/call', {'hierarchy':v:true})<cr>

    " if hidden is not set, TextEdit might fail.
    set hidden

    " Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup

    " Better display for messages
    set cmdheight=2

    " You will have bad experience for diagnostic messages when it's default 4000.
    set updatetime=300

    " don't give |ins-completion-menu| messages.
    set shortmess+=c

    " always show signcolumns
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    nmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <TAB> <Plug>(coc-range-select)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    " Add compile_commands.json as a ccls project.
    " Requires ccls to be installed and a compile_commands.json file to already exist.
    function! AddCclsProject()
        let  l:compile_commands_path = substitute(system("find . -wholename \\*/test_obj/compile_commands.json -print -quit"), '\n\+$', '', '')
        if l:compile_commands_path == ""
            echoerr "Could not find compile_commands.json.  Build unittest for any component to generate it."
        else
            execute "!ln -f -s ".l:compile_commands_path." compile_commands.json"
            call WriteCclsConfigFile()
            :CocRebuild
        endif
    endfunction

    " Write a .ccls file to the current directory
    function! WriteCclsConfigFile()
        " Apply the following to everything in compile_commands.json
        execute "silent !echo \"\\%compile_commands.json\" > .ccls"
        " Treat .h files as C++ headers
        execute "silent !echo \"\\%h -x c++-header\" >> .ccls"
        " Treat .ipp files as C++ headers
        execute "silent !echo \"\\%ipp -x c++-header\" >> .ccls"
        " Tell intrinsics this is an indexing build, so PC_TEST_BUILD_DEF should
        " not be set to 1
        execute "silent !echo \"-DPC_INDEX_COMPILE_TARGET_DEF=1\" >> .ccls"
    endfunction

    " lightline configurations
    let g:lightline = {
          \ 'colorscheme': 'wombat',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'readonly', 'filename', 'modified', 'method' ] ]
          \ },
          \ 'component_function': {
          \   'method': 'NearestMethodOrFunction'
          \ },
          \ }

    set laststatus=2

endif

"-----------------------------------------------------------------------------
" Build tags recursively
"-----------------------------------------------------------------------------
set tags=./tags;/
function! Ctags()
    execute "!ctags -R ."
endfunction

"-----------------------------------------------------------------------------
" Color scheme
"-----------------------------------------------------------------------------
syntax enable

" Custom colorscheme and other vim configurations
if has('gui_running')
    set background=dark
    colorscheme natecolors
else
    colorscheme natecolors
endif

"-----------------------------------------------------------------------------
" Random settings
"-----------------------------------------------------------------------------
let conceallevel=2
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_enabled = 0
let g:indentLine_color_term = 236
let g:indentLine_color_gui = '#A4E57E'

let s:windows = has("win16") || has("win32") || has("win64")

let s:exclude_dirs=['*/*drive',
            \       '*/*bin',
            \       '*/*_obj',
            \       '*/geninclude',
            \       '*/logdesc*',
            \       '*/sharp_tmp',
            \       '*/vortex',
            \       '*/*.git',
            \       '*/*.svn',
            \       '*/*.hg',
            \       '*/*.settings']

if !s:windows
    let s:command = 'find %s '
    for s:dir in s:exclude_dirs
        let s:command .= ' -not \( -path ' . s:dir . ' -prune \)'
    endfor
    let s:command .= ' -type f'
    let g:ctrlp_user_command=s:command
endif

" Remember where the cursor was when reopening a file
function! ResetCursor()
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal! g`\""
    endif
endfunction

au BufReadPost * call ResetCursor()

" prevent single line comments from being automatic, it's annoying
au FileType c,cpp setlocal comments-=:// comments+=f://
au FileType tcl setlocal comments-=:# comments+=f:#

"================== Completion Options ===============
set completeopt=longest,menuone,preview

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).

"-----------------------------------------------------------------------------
"---------------------------- Load work functions ----------------------------
"-----------------------------------------------------------------------------
au Filetype c,cpp :call HighlightHitachiTypes()
au BufNewFile,BufRead *.etm set filetype=etm
au BufNewFile,BufRead *.etl set filetype=etm
au BufNewFile,BufRead trace*.txt set filetype=etm
au BufNewFile,BufRead *.txt.bz2 set filetype=etm
au BufNewFile,BufRead dr_seq.cpp set filetype=dash
au BufNewFile,BufRead *.dis set filetype=dis
au BufNewFile,BufRead *.trc set filetype=evdump
au BufNewFile,BufRead *.fo set filetype=fo
au BufNewFile,BufRead *.sym set filetype=sym

" Get syntax highlighting and autobuilding for plantuml files. Assumes
" plantuml is in you system path for :make to work
" To display images created by uml:
" feh --reload 2
au BufNewFile,BufRead *.uml,*.pu,*.plantuml set filetype=plantuml
au BufWritePost *.uml,*.pu,*.plantuml :make

" Resource vimrc whenever it gets modified. However, it doesn't play well with
" highlightTypes() for some reason, so I'll fix it later.
" au! BufWritePost $MYVIMRC source $MYVIMRC

" Setup tsv rules, we're making a screadsheet. If this is a new file, load the
" template, starting at line 0
au BufNewFile,BufRead,BufEnter *.tsv set ft=tsv
au BufNewFile *.tsv 0r ~/.vim/templates/template.tsv

au BufNewFile,BufRead *.chklst set ft=chklst
let g:checklist_use_timestamps = 0

au BufNewFile *.gnt 0r ~/.vim/bundle/ganttchart/templates/template.gnt

"----------------------------------------
" Git Gutter (performance issues?)
"----------------------------------------
if exists("b:use_gitgutter") && b:use_gitgutter
    Bundle 'airblade/vim-gitgutter'
    let g:gitgutter_realtime = 0
    let g:gitgutter_eager = 0
    highlight clear SignColumn
endif

"-----------------------------------------------------------------------------
"---------------------------Vim Functions/Mappings-----------------------------
"-----------------------------------------------------------------------------
"These functions will work with Vim and GVim

inoremap jj <ESC>

inoremap <M-n> :NERDTreeToggle<CR>
nnoremap <M-n> :NERDTreeToggle<CR>

vnoremap <M-a> :Ag <C-R>"<CR>

" Save files as sudo when I forget to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

"c++, python, vimscript style comment
map ,/ :s/^/\/\//<CR> :/asdfasdf<CR>
map ,# :s/^/#/<CR> :/asdfasdf<CR>
map ," :s/^/"/<CR> :/asdfasdf<CR>
map ,% :s/^/%/<CR> :/asdfasdf<CR>

"c++, python, vimscript style uncomment
map ./ :s/\/\///<CR> :/asdfasdf<CR>
map .# :s/#//<CR> :/asdfasdf<CR>
map ." :s/"//<CR> :/asdfasdf<CR>
map .% :s/%//<CR> :/asdfasdf<CR>

" Move split window to new tab
noremap <C-t> <C-W>T

"CTRL-l/k/j/h moves to another window
noremap <C-l> <C-W>l
noremap <C-k> <C-W>k
noremap <C-j> <C-W>j
noremap <C-h> <C-W>h

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>

map <C-i> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
          \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
          \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Pop a split into a gvim window (Curtacy of Mike)
noremap  <C-W><Leader> :let g:bufpath=expand('%')<CR>:try\|close\|catch\|\|endtry<CR>:exec expand(g:execcmd)." gvim ".expand(g:bufpath)<CR>
let g:execcmd = '!'

"Windows GVim settings
if has("gui_running")
    "set the window size
    set lines=50
    set columns=150

    behave mswin

    "set the 'cpoptions' to its Vim default
    if 1  " only do this when compiled with expression evaluation
        let s:save_cpo = &cpoptions
    endif
    set cpo&vim

    "backspace and allow the cursor keys wrap to previous/next line
    set backspace=indent,eol,start whichwrap+=<,>,[,]

    "backspace in Visual mode deletes selection
    vnoremap <BS> d
endif  "end of if has gui_running

function! CreateEclipseProject()
    let l:eclipsePath = "~/.vim/bundle/eclipsesetup/"
    execute "!echo python3 " . l:eclipsePath ."setupNewEclipseProject.py --project " . expand('%:p:h') . " --xMount /mnt/x"
endfunction

" Fold everything not being serached for
nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

"========================= Function key Mappings ==========================

set autoread

map <F1> :term<CR>
map <F2> :NERDTreeToggle<CR>

nnoremap <F5> :redraw!<CR>

map <F8> :tabnew<CR>
map <C-F8> :tabclose<CR>
map <F9> :call TimeLapse()<CR>

" Show highlight group for thing under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'. synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

if b:use_rtags == 1
    " find references
    map <F3> <leader>rf<CR>
    " Follow declaration location
    map <F4> <leader>rJ<CR>
    map <S-F3> <leader>rS<CR>
    " Call tree
    map <F6> <leader>rF<CR>
    " follow location
    map <C-]> <leader>rj<CR>
    " jump to previous location
    map <C-t> <leader>rb<CR>
    map <F12> :call AddRtagsProject()<CR>
elseif b:use_eclim == 1
    map <F3> :CSearchContext<CR>
    map <F4> :CCallHierarchy<CR>
    map <F6> :CSearchContext -x references<CR>
    map <F7> :CSearch -p 
elseif b:use_coc == 1
    map <F3> :CclsCallHierarchy<CR>
    map <F4> :CclsDerivedHierarchy<CR>
    map <F11> :Vista coc<CR>
    map <F12> :call AddCclsProject()<CR>
endif
