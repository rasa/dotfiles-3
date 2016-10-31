" TODO Check if USER, feature flags etc

" Workman layout
"Plug 'nicwest/vim-workman'
"let g:workman_normal_workman = 0
"let g:workman_insert_workman = 1
"let g:workman_normal_qwerty = 1
"let g:workman_insert_qwerty = 0

"Plug 'nicwest/vim-http'
"Plug 'nicwest/bnext.vim'

" Format any txt file
"Plug 'vim-scripts/Txtfmt-The-Vim-Highlighter'

"if v:version >= 704
"  Plug 'vim-pandoc/vim-pandoc-syntax'
"endif

"Plug 'henrik/vim-indexed-search'

"Plug 'tpope/vim-eunuch'

" Superb motion controls
"Plug 'easymotion/vim-easymotion'

"Plug 'junegunn/vim-pseudocl'
"Plug 'junegunn/vim-oblique'

" Find-N-Replace
"Plug 'junegunn/vim-fnr'

"Plug 'junegunn/vim-peekaboo'

"Plug 'junegunn/vim-easy-align'
"Plug 'thelocehiliosan/vim-byrne'

" Make f usable and more powerful
", {'on': '<Plug>'}
Plug 'rhysd/clever-f.vim'

"" RainbowParantheses
"Plug 'junegunn/rainbow_parentheses.vim'
"Gautocmdft lisp,clojure,scheme RainbowParentheses

"Plug 'vim-scripts/restore_view.vim'

"" Dynamic SQL completion via opening a db connection
"Plug 'vim-scripts/dbext.vim'

" Marks
"Plug 'kshenoy/vim-signature'

"" Lots of script helpers at s:_.blah
"Plug 'vim-jp/vital.vim'
"Plug 'haya14busa/underscore.vim'

"" Abolish: Helpers for searching, substituting, and abbreviating multiple variants at once through {} expansion
"Plug 'tpope/vim-abolish'

"Plug 'eugen0329/vim-esearch'

"let g:esearch = {
"  \ 'adapter':    'ag',
"  \ 'backend':    has('nvim') && 'nvim' || 'vimproc',
"  \ 'out':        'win',
"  \ 'batch_size': 1000,
"  \ 'use':        ['visual', 'hlsearch', 'last'],
"  \}

"" Start esearch prompt autofilled with one of g:esearch.use initial patterns
"call esearch#map('<leader>ff', 'esearch')
"" Start esearch autofilled with a word under the cursor
"call esearch#map('<leader>fw', 'esearch-word-under-cursor')

"call esearch#out#win#map('t',       'tab')
"call esearch#out#win#map('i',       'split')
"call esearch#out#win#map('s',       'vsplit')
"call esearch#out#win#map('<Enter>', 'open')
"call esearch#out#win#map('o',       'open')

""    Open silently (keep focus on the results window)
"call esearch#out#win#map('T', 'tab-silent')
"call esearch#out#win#map('I', 'split-silent')
"call esearch#out#win#map('S', 'vsplit-silent')

""    Move cursor with snapping
"call esearch#out#win#map('<C-n>', 'next')
"call esearch#out#win#map('<C-j>', 'next-file')
"call esearch#out#win#map('<C-p>', 'prev')
"call esearch#out#win#map('<C-k>', 'prev-file')

"call esearch#cmdline#map('<C-o><C-r>', 'toggle-regex')
"call esearch#cmdline#map('<C-o><C-s>', 'toggle-case')
"call esearch#cmdline#map('<C-o><C-w>', 'toggle-word')
"call esearch#cmdline#map('<C-o><C-h>', 'cmdline-help')

"hi ESearchMatch ctermfg=black ctermbg=white guifg=#000000 guibg=#E6E6FA

if has('nvim')
    "Plug 'bfredl/nvim-ipy'
    "Plug 'tek/proteome.nvim'
    "Plug 'hkupty/iron.nvim'
    Plug 'benekastah/neomake'

    "Plug 'arakashic/chromatica.nvim'
    ""let g:chromatica#libclang_path='/usr/local/opt/llvm/lib'
    "let g:chromatica#responsive_mode=1

    "Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
    "function! BuildComposer(info)
    "  if a:info.status != 'unchanged' || a:info.force
    "    !cargo build --release
    "    UpdateRemotePlugins
    "  endif
    "endfunction

    "Plug 'mhinz/vim-grepper'
    "" Mimic :grep and make ag the default tool.
    "let g:grepper = {
    "    \ 'tools': ['ag', 'git', 'grep'],
    "    \ 'open':  0,
    "    \ 'jump':  1,
    "    \ }
endif

Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-rsi'
Plug 'tpope/git-bump'
Plug 'tpope/vim-projectionist'
