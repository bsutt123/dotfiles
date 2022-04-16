call plug#begin()
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'mhinz/vim-mix-format'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jparise/vim-graphql'
Plug 'alvan/vim-closetag'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}

Plug 'neoclide/coc-css', { 'do': 'yarn install --frozen-lockfile' }
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'Quramy/vim-js-pretty-template'
Plug 'elzr/vim-json'
Plug 'tpope/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'vim-ruby/vim-ruby'
Plug 'kamykn/spelunker.vim'
Plug 'sainnhe/sonokai'
Plug 'tpope/vim-surround'
Plug 'janko/vim-test'
call plug#end()
" SECTION: remap files names
nnoremap <leader>qq :q<cr>
nnoremap <leader>qa :qa!<cr>
nnoremap <leader>qw :wq!<cr>
nnoremap <leader>fs :w<cr>
nnoremap <leader>qd :qa!<cr>

nnoremap <leader>xx :x!<cr>

nnoremap <leader>ee :e!<cr>

noremap <silent><leader>rb :bufdo e!<cr>

nnoremap <esc> :noh<return><esc>

" SECTION: coloring
syntax on
let g:sonokai_style = 'default'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_cursor = 'green'
colorscheme sonokai

" Override highlight setting.
highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE

highlight ColorColumn ctermbg=0 guibg=#3d3d38

"" SECTION: general
"""Source (reload) your vimrc. Type space, s, o in sequence to trigger

nmap <leader>so :source $MYVIMRC<cr>

set encoding=utf-8

" Leader
let mapleader = "\<Space>"

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on
filetype plugin on

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ackprg = 'ag --vimgrep --path-to-ignore ~/,ignore'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Make it obvious where 80 characters is
au BufRead,BufNewFile *.md, *.mdx setlocal textwidth=80

" Numbers
set numberwidth=5

" Split configuration {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Always use vertical diffs
set diffopt+=vertical
set updatetime=200

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

"" SECTION: vim plug commands
nnoremap <Leader>pc :PlugClean<cr>
nnoremap <Leader>pi :PlugInstall<cr>

" SECTION: insert tab wrapper
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction

inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

" SECTION: Ack - Integrata ack (grep replacement) into vim
nmap <leader>ck :Ack!<space>
nnoremap <leader>cc :cclose<cr>

function! s:VisualAck()
  let temp = @"
  normal! gvy
  let escaped_pattern = escape(@", "[]().*")
  let @" = temp
  execute "Ack! -Q '" . escaped_pattern . "'"
endfunction


" bind K to grep word under cursor
nnoremap K :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>
vnoremap K :<C-u>call <sid>VisualAck()<cr>

let g:ackprg = 'ag --nogroup --nocolor --column --ignore node_modules --ignore build'

"" Better whitespace
nnoremap <leader>wht :StripWhitespace<cr>:w<cr>

"" SECTION elixir
let g:mix_format_on_save = 1

"" SECTION fzf
nnoremap <leader>ff :Files!<CR>
" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" }}}
" ack {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


"" SECTION html - close tag
""mes like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*.js,*.ts,*.ex,*.leex,*.html.*'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx,*.js,*.ts,*.ex,*.leex,*.html.*'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml,leex,ex'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx,leex,ex,html'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'

"" SECTION: COC

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=3
set pyxversion=3

let g:python3_host_prog = '/usr/local/bin/python3'

" let g:coc_force_debug = 1

"  Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" use tab and shift-tab to navigate completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

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

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" create prettier command
command! -nargs=0 CocPrettier :CocCommand prettier.formatFile
nnoremap <leader>pf :CocPrettier<cr>

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

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

let g:coc_global_extensions = [
        \  'coc-css',
        \  'coc-elixir',
        \  'coc-emmet',
        \  'coc-eslint',
        \  'coc-graphql',
        \  'coc-highlight',
        \  'coc-html',
        \  'coc-json',
        \  'coc-snippets',
        \  'coc-solargraph',
        \  'coc-sql',
        \  'coc-svg',
        \  'coc-tsserver',
        \  'coc-yaml',
        \  'coc-yank',
        \  'coc-prettier']

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

"" SECTION typescript/javascript
autocmd BufEnter *.es6 setf javascript
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

"" SECTION: JSON

let g:vim_json_syntax_conceal = 0

"" SECTION markdown
let g:markdown_fenced_languages = [
      \ 'sql',
      \ 'javascript',
      \ 'ruby',
      \ 'sh',
      \ 'yaml',
      \ 'javascript',
      \ 'html',
      \ 'vim',
      \ 'json',
      \ 'diff',
      \ 'css',
      \ 'scss',
      \ 'haskell',
      \ 'python'
      \ ]
"" SECTION NerdTree
let NERDTreeShowHidden=2
" Inline menu with `m` shortcut
let NERDTreeMinimalMenu=1
" Hide help message, etc.
let NERDTreeMinimalUI=1
" Change current working directory based on root directory in NERDTree
let NERDTreeChDirMode=2
" Initial NERDTree width
let NERDTreeWinSize=36

" Tree mappings
nnoremap <leader>ntt :NERDTreeToggle<cr>
nnoremap <leader>ntr :NERDTreeFocus<cr>
nnoremap <leader>ntf :NERDTreeFind<cr>

"" SECTION frozen string
function! FrozenString()
  call append(line("gg"), "")
  call append(line("gg"), "# frozen_string_literal: true")
endfunction

nnoremap <leader>fl :call FrozenString()<cr>

"" SECTION spell check
set nospell

let g:spelunker_check_type = 2

nmap [s ZP
nmap ]s ZN
nmap <leader>sc ZL
nmap <leader>sa Zg
nnoremap <leader>st ZT
nnoremap <leader>sla :SpelunkerAddAll<cr>

"" SECTION: test

" vim-test mappings
nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>ts :TestSuite<CR>
nnoremap <silent> <Leader>tv :TestVisit<CR>

let test#strategy = 'kitty'
let test#ruby#rspec#executable = 'bundle exec rspec'
let test#ruby#cucumber#executable = 'bundle exec cucumber'

let g:test#javascript#runner = 'jest'
let test#javascript#jest#file_pattern = '\.spec\.ts'
let test#javascript#jest#executable = "npm run jest"
let test#neovim#term_position = "topleft"