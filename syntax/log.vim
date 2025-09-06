set cursorline

syntax match controller "controller\/.\{-} "
syntax match error /"error"=".\{-}[^\\]"/
syntax match name /"name"=".\{-}[^\\]"/
syntax match namespace /"namespace"=".\{-}[^\\]"/

highlight controller ctermfg=Green guifg=Green
highlight error ctermfg=red guifg=red
highlight name ctermfg=yellow guifg=yellow
highlight namespace ctermfg=yellow guifg=yellow
"hi CursorLine cterm=NONE ctermbg=darkred guibg=darkred

