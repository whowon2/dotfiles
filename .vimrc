" ==================================
" Plugins
" ==================================
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'scrooloose/nerdtree'
Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ryanoasis/vim-devicons'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vbe0201/vimdiscord'
Plug 'vim-test/vim-test'

call plug#end()

"
" general settings
"
set number
set relativenumber

set cursorline

set smarttab
set expandtab

set tabstop=2
set shiftwidth=2

set nowrap

set backspace=indent,eol,start

set encoding=UTF-8

" Tabbing shortcuts
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>

noremap <C-S-Tab> :<C-U>tabp<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabp<CR>
cnoremap <C-S-Tab> <C-C>:tabp<CR>

" Set Ctrl+S to save file
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a
vnoremap <c-s> <Esc>:w<CR>a
inoremap <c-s> <Esc>:w<CR>a

" setup default vim finder
set path+=**

set wildmenu

" For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 
" Based on Vim patch 7.4.1770 (`guicolors` option)
if (has("termguicolors"))
  set termguicolors
endif

" Set Ctrl+Z and Ctrl+Shift+Z to undo/redo actions
noremap <C-z> :u<CR>
noremap <C-S-z> :redo<CR>

map <C-z> :u<CR>
map <C-S-z> :redo<CR>

"
" For fuzzy finder(ctrlp)
"
let g:ctrlp_user_command = [
\   '.git/',
\   'git --git-dir=%s/.git ls-files -oc --exclude-standard'
\ ]

"
" Vim prettier
"
let g:prettier#quickfix_enabled = 1
let g:prettier#quickfix_auto_focus = 1
let g:prettier#autoformat = 1

command! -nargs=0 Prettier :CocCommand prettier.formatFile

"
" Vimspect
"
let g:vimspector_enable_mappings = 'HUMAN'

sign define vimspectorBP text=🔴 texthl=Normal
sign define vimspectorBPDisabled text=🔵 texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad


"
" NerdTree settings
"
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

let g:NERDTreeGitStatusWithFlags = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeColorMapCustom = {
\  "Staged": "#0ee375",  
\  "Modified": "#d9bf91",  
\  "Renamed": "#51C9FC",  
\  "Untracked": "#FCE77C",  
\  "Unmerged": "#FC51E6",  
\  "Dirty": "#FFBD61",  
\  "Clean": "#87939A",   
\  "Ignored": "#808080"   
\ }


" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

function! IsNerdTreeOpen()
	return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind if NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
	if &modifiable && IsNerdTreeOpen() && strlen(expand('%')) > 0 && !&diff
		NERDTreeFind
		wincmd p
	endif
endfunction

" -------------------------------------------------------------------------------------------------------------
" -------------------------------------------------------------------------------------------------------------
" -------------------------------------------------------------------------------------------------------------
" -------------------------------------------------------------------------------------------------------------

" Use tab for trigger completion with characters ahead and navigate
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

" Use [g and ]g to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use Enter to confirm completion, Ctrl-G+U means break undo chain at current position
" Coc only does snippet and additional edit on confirm
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>ShowDocumentation()<CR>

" Show documentation on hover definition
function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap F2/Shift-F6 for rename current word
nmap <F2> <Plug>(coc-rename)
nmap <S-F6> <Plug>(coc-rename)

" Remap Leader for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Create mappings for function text object, requires document symbols feature of language-server
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)


" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" CocList

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