set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "bryantebeek"

hi Comment                   ctermfg=235
hi Constant                  ctermfg=67
hi Cursor                    ctermbg=255
hi CursorLine                cterm=none ctermbg=234
hi CursorLineNr              ctermfg=242
hi Define                    ctermfg=130
hi Delimiter                 ctermfg=11
hi Directory                 ctermfg=161
hi Error                     ctermfg=255
hi Folded                    ctermfg=254
hi Function                  ctermfg=167
hi Identifier                ctermfg=167
hi Include                   ctermfg=130
hi Keyword                   ctermfg=130
hi LineNr                    ctermfg=235
hi Macro                     ctermfg=130
hi Normal                    ctermfg=255
hi Number                    ctermfg=30
hi PreCondit                 ctermfg=130
hi PreProc                   ctermfg=209
hi Search                    ctermbg=240 ctermfg=255
hi Statement                 ctermfg=130
hi String                    ctermfg=11
hi Title                     ctermfg=16
hi Todo                      ctermfg=161
hi Type                      ctermfg=161
hi Visual                    ctermbg=236

" Javascript
hi javaScriptBraces          ctermfg=255
hi javaScriptGlobal          ctermfg=255
