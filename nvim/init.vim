set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set ignorecase smartcase
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
"set termguicolors

" terminal settings
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * map <A-e> a<A-e>
"tnoremap <F2> <C-\><C-n>
":tnoremap <C-w> <C-\><C-n><C-w>
tnoremap <Esc> <C-\><C-n>

" Aliases
command Date1 read !date '+\%d \%B \%Y, \%A, Week \%W'

" Numbers
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

"tab stuff
set tabstop=4
set autoindent
set smartindent
set smarttab

" format-dependent stuff
autocmd FileType yaml setlocal list | setlocal lcs+=space:· | setlocal nowrap
autocmd FileType tex setlocal linebreak
autocmd FileType markdown setlocal linebreak
autocmd FileType fstab setlocal list | setlocal nowrap
autocmd FileType yaml,json setlocal expandtab shiftwidth=2 tabstop=2

" wrapping
set sidescroll=5
set listchars+=precedes:<,extends:>

" Plugins
let g:table_mode_corner='|'
let g:unception_block_while_host_edits=1
let g:livepreview_engine = 'xelatex' . ' [--interaction=nonstopmode] '

function! MyTabLine()
    let s = ''
    "let s .= '%='
    for i in range(tabpagenr('$'))
      " set up some oft-used variables
      let tab = i + 1 " range() starts at 0
      let winnr = tabpagewinnr(tab) " gets current window of current tab
      let buflist = tabpagebuflist(tab) " list of buffers associated with the windows in the current tab
      let bufnr = buflist[winnr - 1] " current buffer number
      let bufname = bufname(bufnr) " gets the name of the current buffer in the current window of the current tab
      let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#') " if this tab is the current tab...set the right highlighting
      let s .= '%='
      "let s .= ' ' . tab " current tab number
      if bufname != ''
        let s .= ' ' . pathshorten(bufname) . ' ' " outputs the one-letter-path shorthand & filename
      else
        let s .= '[No Name]'
      endif
      let bufmodified = getbufvar(bufnr, "&mod")
      if bufmodified
        let s .= '[+]'
      endif
      let n = tabpagewinnr(tab,'$') " get the number of windows in the current tab
      if n > 1
        let s .= '(' . n . ')'" if there's more than one, add a colon and display the count
      endif
      let s .= '%='
    endfor
    "let s .= '%='
    let s .= '%#TabLineFill#' " blank highlighting between the tabs and the righthand close 'X'
    "let s .= '%T' " resets tab page number?
    "let s .= '%#TabLine#' " set highlight for the 'X' below
    "let s .= '%999XX' " places an 'X' at the far-right
    return s
endfunction

set tabline=%!MyTabLine()
