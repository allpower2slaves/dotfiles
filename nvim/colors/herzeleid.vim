hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

runtime colors/vim.lua
let g:colors_name = "herzeleid"

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight CursorLineNr term=bold cterm=NONE ctermfg=Yellow ctermbg=NONE gui=NONE guifg=Yellow guibg=NONE

highlight VertSplit ctermfg=237 guifg=Grey23

hi Whitespace ctermfg=238 guifg=Grey15

hi MatchParen cterm=none ctermbg=172 ctermfg=0

hi StatusLine ctermfg=Yellow guifg=#ffff60 ctermbg=239 guibg=Grey30 cterm=bold gui=bold
hi StatusLineNC ctermfg=249 guifg=Grey70 ctermbg=237 guibg=Grey23 cterm=none gui=none

hi! default link StatusLineTerm StatusLine
hi! default link StatusLineTermNC StatusLineNC

hi TabLineFill ctermfg=237 ctermbg=Black guifg=Grey23 guibg=Grey23 gui=none
hi TabLineSel ctermfg=Yellow ctermbg=239 guifg=#ffff60 guibg=Grey30 gui=bold " what
hi TabLine ctermfg=249 ctermbg=237 guifg=Grey70 guibg=Grey23
