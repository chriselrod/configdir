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
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'
    "Plug 'ycm-core/YouCompleteMe'
    Plug 'jez/vim-ispc'
    Plug 'ziglang/zig.vim'
    Plug 'rust-lang/rust.vim'
    Plug 'simrat39/rust-tools.nvim'
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
"let g:ycm_clangd_uses_ycmd_caching = 0
"" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
"let g:ycm_clangd_binary_path = exepath("clangd")
"nnoremap <leader>lf :YcmCompleter FixIt <CR>
"nnoremap <leader>ld :YcmCompleter GoTo <CR>
"nnoremap <leader>lr :YcmCompleter RefactorRename 

lua << EOF
local nvim_lsp = require'lspconfig'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>le', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      -- Tab immediately completes. C-n/C-p to select.
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
      -- ['<C-n>'] = cmp.mapping({
      --   i = function(fallback)
      --     local lcmp = require('cmp')
      --     if #lcmp.core:get_sources() > 0 and not lcmp.get_config().experimental.native_menu then
      --       if lcmp.visible() then
      --         lcmp.select_next_item()
      --       else
      --         lcmp.complete()
      --       end
      --     else
      --       fallback()
      --     end
      --   end,
      -- }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    completion = {
      autocomplete = false, -- disable auto-completion.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    }),
    experimental = {
        ghost_text = true,
    },
})

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline(':', {
  --   sources = cmp.config.sources({
  --     { name = 'path' }
  --   }, {
  --     { name = 'cmdline' }
  --   })
  -- })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = { 'pyright', 'clangd' }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end
    nvim_lsp.rust_analyzer.setup({
        on_attach=on_attach,
        capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
                },
            cargo = {
                loadOutDirsFromCheck = true
                },
            procMacro = {
            enable = true
            },
        }
    }
    })

    local opts = {
    tools = { -- rust-tools options
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,

        -- Whether to show hover actions inside the hover window
        -- This overrides the default hover handler 
        hover_with_actions = true,

		-- how to execute terminal commands
		-- options right now: termopen / quickfix
		-- executor = require("rust-tools/executors").termopen,

        runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {

            -- Only show inlay hints for the current line
            only_current_line = false,

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",

            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = true,

            -- prefix for parameter hints
            parameter_hints_prefix = " <- ",

            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = " ➫  ",

            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,

            -- The color of the hints
            highlight = "NonText",
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                {"╭", "FloatBorder"}, {"─", "FloatBorder"},
                {"╮", "FloatBorder"}, {"│", "FloatBorder"},
                {"╯", "FloatBorder"}, {"─", "FloatBorder"},
                {"╰", "FloatBorder"}, {"│", "FloatBorder"}
            },

            -- whether the hover action window gets automatically focused
            auto_focus = false
        },

        -- settings for showing the crate graph based on graphviz and the dot
        -- command
        crate_graph = {
            -- Backend used for displaying the graph
            -- see: https://graphviz.org/docs/outputs/
            -- default: x11
            backend = "x11",
            -- where to store the output, nil for no output stored (relative
            -- path from pwd)
            -- default: nil
            output = nil,
            -- true for all crates.io and external crates, false only the local
            -- crates
            -- default: true
            full = true,
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
	server = {
		-- standalone file support
		-- setting it to false may improve startup time
		standalone = true,
	}, -- rust-analyer options
}

require('rust-tools').setup(opts)
EOF

" Rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip'

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
