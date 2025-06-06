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
let g:table_mode_corner='|'
let g:unception_block_while_host_edits=1
let g:livepreview_engine = 'xelatex' . ' [--interaction=nonstopmode] '
