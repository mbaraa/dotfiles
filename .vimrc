set nocompatible              " be iMproved, required
filetype off                  " required

" for vim-devicons
set encoding=UTF-8

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" HTML linter
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" vim airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" vim go support
Plugin 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" brogrammer theme
Plugin 'marciomazza/vim-brogrammer-theme'
" nerd tree
Plugin 'scrooloose/nerdtree'
" tagbar displays functions' ans classes' names
Plugin 'majutsushi/tagbar'
"  Line up text in a tabular format :Tab /=
Plugin 'vim-scripts/Tabular'
" Adds file type icons to Vim plugins such as: NERDTree
Plugin 'ryanoasis/vim-devicons'
" highlight trailing whitespaces
Plugin 'ntpeters/vim-better-whitespace'

" themes
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'ghifarit53/tokyonight-vim'
Plugin 'morhetz/gruvbox'

" rust
Plugin 'rust-lang/rust.vim'
" Plugin 'racer-rust/vim-racer'
Plugin 'phildawes/racer'

" code formatter
" Plugin 'chiel92/vim-autoformat'

" auto complete
Plugin 'tomtom/tcomment_vim'

" Syntax HL for Vue.js
" Plugin 'posva/vim-vue'
" C++
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'rip-rip/clang_complete'

" vdbi
Plugin 'mattn/webapi-vim'
Plugin 'mattn/vdbi-vim'

" react/typescript
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'styled-components/vim-styled-components', { 'branch': 'main' }
Plugin 'jparise/vim-graphql'
" format
" Plugin 'sbdchd/neoformat'

" svelte
Plugin 'evanleck/vim-svelte'
Plugin 'codechips/coc-svelte', {'do': 'npm install'}
Plugin 'othree/html5.vim'
" coc autocomplete
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" brackets enhancers
Plugin 'frazrepo/vim-rainbow'
Plugin 'reconquest/vim-autosurround'

" fuzzy finder
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

Plugin 'ervandew/eclim'

Plugin 'benmills/vimux'

" the mighty debugger
Plugin 'puremourning/vimspector'


" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin on

" Svelte
let g:svelte_preprocessors = ['typescript']
au FileType *.svelte set syntax=html

" brackets
" au FileType c,cpp,cs,java,js,jsx,ts,tsx,go,vue,sh,kt,rs,py,svelte call rainbow#load()
" let g:rainbow_active = 1
"
" let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
" let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
" let g:rainbow_active = 1


" vim-go
map <F10> :GoRun<CR>
map <F11> :GoBuild<CR>
filetype plugin indent on

set autowrite

" format js/ts
" autocmd BufWritePre *.{js,ts,jsx,tsx} Neoformat
" autocmd BufWritePre,TextChanged,InsertLeave *.{js,ts,jsx,tsx} Neoformat

" Go syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 1


" Status line types/signatures
let g:go_auto_type_info = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction
" auto auto completion
" au filetype go inoremap <buffer> . .<C-x><C-o>

" Rust racer
let g:racer_cmd = "/home/bebo/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1

" Java stuff
" build
noremap <leader>ds :VimuxRunCommand "mvn -Dmaven.surefire.debug  -Dtest=".expand("%:t:r")." test --offline"<CR>
" debug
map <leader>at :CocCommand java.debug.vimspector.start<CR>


" theme
syntax enable
set termguicolors

let g:gruvbox_italic=1


" let g:lightline = {'colorscheme' : 'tokyonight'}
" let g:tokyonight_style = 'night' " available: night, storm
" let g:tokyonight_enable_italic = 1

colorscheme gruvbox
" colorscheme tokyonight
" colorscheme dracula

" let g:airline_theme = "tokyonight"
let g:airline_theme='gruvbox'

set background=dark
" transparent background
" hi Normal guibg=NONE ctermbg=NONE
" highlight Normal ctermfg=white ctermbg=black

" airline
" let g:airline#extensions#tabline#enabled = 1 " top airline bar
let g:airline#extensions#tabline#left_sep = '|'
let g:airline#extensions#tabline#left_alt_sep = '|'


" line wrapping
set nowrap

" tagbar
nmap <F8> :TagbarToggle<CR>
" autocmd BufRead,BufNewFile *.{go,py,cpp,c,kt,java,rs,js,ts,vue,jsx,tsx} :TagbarToggle

" nerd tree
map <F5> :NERDTreeToggle<CR>
autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" let g:NERDTreeQuitOnOpen          = 1
let NERDChristmasTree           = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeShowHidden          = 1
let NERDTreeMapActivateNode     = '<CR>'
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror
" exit w/ vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" hello!
" to navigate tabs use 'gt' and 'gT'

" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" numbers blyat
:set number relativenumber
nmap <F3> :set number! relativenumber!<CR>

" vim-autoformat
" au BufWrite * :Autoformat " format file before saving
" nmap <ALT-f> :AutoFormat<CR>

" tComment
nmap <C-/> :TComment<CR>

" select all in file
function! s:copy_all()
    " go to the first line
    :0
    " select line mode
    normal Vip
    " go to the last line
    :$
    " yank into + register which is the system's clipboard
    normal "+y
endfunction
nmap <C-c> :call <SID>copy_all()<CR>

" highlight rows and columns
autocmd WinLeave * set nocursorline nocursorcolumn
autocmd WinEnter * set cursorline cursorcolumn

" leader key
let mapleader = " " " map leader to Space

" resize
map <leader>+ :res +5<CR>
map <leader>- :res -5<CR>
map <leader>p :vertical res +5<CR>
map <leader>m :vertical res -5<CR>

" set tab size
set tabstop=4
set shiftwidth=4
set expandtab

" coc stuff
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
