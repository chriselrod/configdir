set nocompatible
filetype off
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
    " File
    Plug 'ojroques/vim-oscyank'
    Plug 'scrooloose/nerdtree'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
    " Theme
    Plug 'morhetz/gruvbox'
    Plug 'lifepillar/vim-solarized8'
    " Lang
    Plug 'neovim/nvim-lsp'
    Plug 'ycm-core/YouCompleteMe'
    Plug 'jez/vim-ispc'
    Plug 'ziglang/zig.vim'
    Plug 'rust-lang/rust.vim'
    Plug 'JuliaEditorSupport/julia-vim', { 'on_ft': 'julia' }
    Plug 'sbdchd/neoformat'
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'
    " Chinese
    "Plug 'lilydjwg/fcitx.vim'
    " Writing
    Plug 'lervag/vimtex'
    Plug 'junegunn/goyo.vim'
call plug#end()
filetype plugin indent on
" Neovim Setting
" Basic settings
set nomodeline number mouse=a so=5
" Movements
vmap < <gv
vmap > >gv
map <esc> :noh<cr>
" Python setup
let g:python3_host_prog = '/usr/bin/python'
" File browsing
map - :NERDTreeToggle<CR>
" No beeping
set visualbell noerrorbells
" Fast scrolling
"set synmaxcol=256
syntax sync minlines=256
" encode
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gbk,latin1
" Clipboard
set clipboard+=unnamedplus
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
set nopaste noshowmode
filetype on
" Indent
set tabstop=4 shiftwidth=4 expandtab
"set expandtab autoindent smartindent copyindent   " always set autoindenting on & copy the previous indentation on autoindenting
" block select not limited by shortest line
set virtualedit=
set wildmenu
"set colorcolumn=100
set wrap linebreak
set wildmode=full
set notimeout
" leader is ,
let maplocalleader = " "
let mapleader = " "
set ls=0
" No copy on delete
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
" Move a line/block up & down by Alt+{j,k}
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" History
set undofile undodir=~/.vim/undo/ undolevels=1000 undoreload=10000
" FZF
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
nnoremap <leader>gc :Commits<CR>
nnoremap <leader>gb :BCommits<CR>
nnoremap <leader>gg :GGrep<CR>
nnoremap <leader>gf :GFiles<CR>
"nnoremap <silent> <leader>ft :Filetypes<CR>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
imap <c-x><c-x> <plug>(fzf-maps-i)
" Leader
nnoremap <leader>s :split<CR>
nnoremap <leader>v :vsplit<CR>
" Don't move the cursor
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction
" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif

" interactive search replace
set inccommand=split
"map - :E<CR>
" Lang
set textwidth=80 colorcolumn=80 " and give me a colored column
"set formatoptions-=t " don't auto wrap a line
set formatoptions+=l " keep some long lines
set conceallevel=0 " more explicit
set spelllang=en
set spellfile=~/.vim/spell/en.utf-8.add
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nnoremap <F6> :%s/[\u4e00-\u9fff]//gn<CR>
nnoremap <F7> :setlocal foldmethod=syntax<CR>
nnoremap <F8> :setlocal spell! spelllang=en_us<CR>
autocmd BufNewFile,BufRead *.mmark set filetype=markdown
autocmd BufNewFile,BufRead *.jmd set filetype=markdown
autocmd BufNewFile,BufRead *.c set tabstop=2 shiftwidth=2 expandtab
autocmd BufNewFile,BufRead *.jl nnoremap <leader>B :let @+ = 'breakpoint(' . join(['"' . expand('%:p') . '"',  line(".")], ',') . ')' <CR>
autocmd BufNewFile,BufRead *.tex,*.bib setlocal ts=2 sw=2
autocmd FileType gitcommit,markdown,text,html,tex setlocal spell complete+=kspell formatoptions+=m " line break for Chinese
" Julia
let g:default_julia_version = "devel"
autocmd BufRead,BufNewFile $HOME/src/*/*DiffEq/* setlocal ts=2 sw=2
autocmd BufRead,BufNewFile $HOME/src/*/Pumas/* setlocal ts=2 sw=2
autocmd BufRead,BufNewFile $HOME/src/*/SciML*/* setlocal ts=2 sw=2
autocmd BufRead,BufNewFile $HOME/src/*/NonlinearSolve/* setlocal ts=2 sw=2
autocmd BufRead,BufNewFile $HOME/src/*/DiscoDiffEq*/* setlocal ts=4 sw=4
autocmd BufRead,BufNewFile $HOME/src/*/ArrayInterface/* setlocal ts=2 sw=2
autocmd BufRead,BufNewFile $HOME/src/*/Pumas/* setlocal ts=2 sw=2
autocmd BufRead,BufNewFile $HOME/src/*/DiffEqGPU/* setlocal ts=4 sw=4
" language server
"lua << EOF
"require'lspconfig'.julials.setup({
"      on_new_config = function(new_config,new_root_dir)
"      cmd = {
"        "julia",
"        "--project=/Users/scheme/src/julia/lsp",
"        "--startup-file=no",
"        "--history-file=no",
"        "-e", [[
"          using Pkg;
"          Pkg.instantiate()
"          using LanguageServer; using SymbolServer;
"          depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
"          project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
"          # Make sure that we only load packages from this environment specifically.
"          @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
"          server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
"          server.runlinter = true;
"          run(server);
"        ]]
"    };
"    new_config.cmd = cmd
"    end
"})
"EOF
"
"autocmd Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc
"
"nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> <c-l> <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
"nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>

" C++
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
nnoremap <leader>lf :YcmCompleter FixIt <CR>
nnoremap <leader>ld :YcmCompleter GoTo <CR>
nnoremap <leader>lr :YcmCompleter RefactorRename 

lua << EOF
require'lspconfig'.clangd.setup{}
EOF

" LaTeX
let g:tex_flavor='xelatex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_complete_enabled=0
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
" Special characters
function! ShowDigraphs()
    digraphs
    call getchar()
    return "\<C-k>"
endfunction
inoremap <expr> <C-k> ShowDigraphs()
map <F11> :w<bar>make!<bar>cclose <CR>
set list
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→
" Git
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)
" Theme
"set termguicolors
syntax on
"let g:gruvbox_contrast_dark = "hard"
"let g:gruvbox_contrast_light = "hard"
"colorscheme gruvbox
let g:solarized_visibility = "high"
let g:solarized_diffmode = "high"
let g:solarized_termtrans = 1
colorscheme solarized8
set laststatus=0
