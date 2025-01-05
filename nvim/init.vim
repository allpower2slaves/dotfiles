set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set ignorecase
set numberwidth=1
set mouse =
"set autochdir
set splitbelow splitright
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "disable autocommenting on newline
"set shellcmdflag=-ic
set cursorline
set cursorlineopt=number

"terminal scollback
set scrollback=20000

"my colorscheme was moved to `./colors/herzeleid.vim`
colorscheme herzeleid
set notermguicolors "for nvim 0.10.0


autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * map <A-e> a<A-e>
"tnoremap <F2> <C-\><C-n>
":tnoremap <C-w> <C-\><C-n><C-w>
:tnoremap <Esc> <C-\><C-n>



" #D8D849 -- possible yellow color (:Man command outputs yellow)
" set cterm color to "Yellow"

" Aliases
command Date1 read !date '+\%d \%B \%Y, \%A, Week \%W'
command Fish terminal fish

" command CopyC normal gg"+yG
" command CC CopyC
" deprecated by `%+y`
"alias date1="date '+%d %B %Y, %A, Week %W'"

"Command LPreview ! xelatex -interaction=nonstopmode %

" Numbers
:set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END


"autocmd BufEnter,BufNewFile *.yaml,*.yml setlocal lcs+=space:·
autocmd FileType yaml setlocal list | setlocal lcs+=space:·
autocmd FileType tex setlocal linebreak
autocmd FileType markdown setlocal linebreak



" Plugins

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
"   Make sure you use single quot

Plug 'dhruvasagar/vim-table-mode'
Plug 'samjwill/nvim-unception'
"Plug 'MunifTanjim/nui.nvim'
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"Plug 'mzlogin/vim-markdown-toc'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-neo-tree/neo-tree.nvim'
"Plug 'nvim-tree/nvim-tree.lua'
"Plug 'nvim-tree/nvim-web-devicons'
"Plug 'preservim/nerdtree'
"Plug 'smjonas/live-command.nvim'
"Plug 'ujihisa/tabpagecolorscheme' " individual color schemes for tabs
"Plug 'vim-scripts/info.vim'
"Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
"call plug#begin('~/.config/nvim/plugged')
call plug#end()

"Tcolorscheme herzeleid " weird hack for tabpagecolorscheme

let g:table_mode_corner='|'
let g:unception_block_while_host_edits=1
let g:livepreview_engine = 'xelatex' . ' [--interaction=nonstopmode] '

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
