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

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=Grey30 guibg=NONE
highlight CursorLineNr term=bold cterm=NONE ctermfg=Yellow ctermbg=NONE gui=NONE guifg=#ffff60 guibg=NONE

"hi 

hi Whitespace ctermfg=235 guifg=Grey15

hi MatchParen cterm=none ctermbg=172 ctermfg=0

hi StatusLine ctermfg=Yellow guifg=#ffff60 ctermbg=none guibg=none cterm=underline gui=underline
hi StatusLineNC ctermfg=244 guifg=Grey50 ctermbg=none guibg=none cterm=underline gui=underline

hi! default link StatusLineTerm StatusLine
hi! default link StatusLineTermNC StatusLineNC

hi TabLineFill ctermfg=244 ctermbg=Black guifg=Grey50 guibg=none cterm=underline gui=underline "none kinda breaks on notermguicolors
hi TabLineSel ctermfg=Yellow ctermbg=none guifg=#ffff60 guibg=none gui=underline " what
hi TabLine ctermfg=244 ctermbg=none guifg=Grey50 guibg=none gui=underline
