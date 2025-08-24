hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults. TODO: use autocmd with ColorSchemePre
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

runtime colors/vim.lua
let g:colors_name = "herzeleid"

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=Grey30 guibg=NONE
highlight CursorLineNr term=bold cterm=NONE ctermfg=Yellow ctermbg=NONE gui=NONE guifg=#ffff60 guibg=NONE

hi VertSplit ctermfg=235 guifg=Grey15 "warning: check init.vim

hi Whitespace ctermfg=235 guifg=Grey15

hi MatchParen cterm=none ctermbg=172 ctermfg=0

hi StatusLine ctermfg=Yellow guifg=#ffff60 ctermbg=none guibg=none cterm=none gui=none
hi StatusLineNC ctermfg=244 guifg=Grey50 ctermbg=none guibg=none cterm=none gui=none

hi! default link StatusLineTerm StatusLine
hi! default link StatusLineTermNC StatusLineNC

hi TabLineFill ctermfg=244 ctermbg=Black guifg=Grey50 guibg=none cterm=none gui=none "none kinda breaks on notermguicolors
hi TabLineSel ctermfg=Yellow ctermbg=none guifg=#ffff60 guibg=none cterm=none gui=none " what
hi TabLine ctermfg=244 ctermbg=none guifg=Grey50 guibg=none cterm=none gui=none

hi Removed ctermfg=9 guifg=Red3
hi Added ctermfg=10 guifg=Green1
