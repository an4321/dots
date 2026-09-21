highlight clear
if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "term"
set notermguicolors

" Background & UI Transparency
hi Normal           cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi NormalFloat      cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi FloatBorder      cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi StatusLine       cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi StatusLineNC     cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi StatusLineTerm   cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi StatusLineTermNC cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE

" Line Numbers -> Dark Gray (8)
hi LineNr           ctermfg=0    ctermbg=NONE guifg=Black guibg=NONE
hi CursorLineNr     ctermfg=0    ctermbg=NONE guifg=Black guibg=NONE

" Tab character / listchars (>, etc.) -> Dark Gray (8)
hi Whitespace       ctermfg=0    ctermbg=NONE guifg=Black guibg=NONE
hi NonText          ctermfg=0    ctermbg=NONE guifg=Black guibg=NONE
hi SpecialKey       ctermfg=0    ctermbg=NONE guifg=Black guibg=NONE

" Completion Box & Wildmenu
hi Pmenu            cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE  guibg=NONE
hi PmenuSel         cterm=NONE gui=NONE ctermfg=0    ctermbg=3    guifg=White guibg=Yellow
hi PmenuKind        cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE  guibg=NONE
hi PmenuKindSel     cterm=NONE gui=NONE ctermfg=15   ctermbg=3    guifg=White guibg=Yellow
hi PmenuExtra       cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE  guibg=NONE
hi PmenuExtraSel    cterm=NONE gui=NONE ctermfg=15   ctermbg=3    guifg=White guibg=Yellow
hi PmenuSbar        cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE  guibg=NONE
hi PmenuThumb       cterm=NONE gui=NONE ctermfg=NONE ctermbg=3    guifg=NONE  guibg=Yellow
hi WildMenu         cterm=NONE gui=NONE ctermfg=0    ctermbg=3    guifg=Black guibg=Yellow

" Bracket Matching -> Black FG (0), Yellow BG (3), No Underline
hi MatchParen       cterm=NONE gui=NONE ctermfg=0 ctermbg=1 guifg=Black guibg=Red

" Syntax Rules
hi Comment          ctermfg=6    ctermbg=NONE guifg=Cyan     guibg=NONE
hi String           ctermfg=2    ctermbg=NONE guifg=Green    guibg=NONE

" Constants (Numbers, Booleans, Floats) -> Green (2)
hi Constant         ctermfg=2    ctermbg=NONE guifg=Green    guibg=NONE
hi Character        ctermfg=2    ctermbg=NONE guifg=Green    guibg=NONE
hi Number           ctermfg=2    ctermbg=NONE guifg=Green    guibg=NONE
hi Boolean          ctermfg=2    ctermbg=NONE guifg=Green    guibg=NONE
hi Float            ctermfg=2    ctermbg=NONE guifg=Green    guibg=NONE

" Variable & Function Declarations -> Blue (4)
hi Function         ctermfg=4    ctermbg=NONE guifg=Blue     guibg=NONE
hi Identifier       ctermfg=4    ctermbg=NONE guifg=Blue     guibg=NONE
hi StorageClass     ctermfg=3    ctermbg=NONE guifg=Yellow   guibg=NONE
hi Structure        ctermfg=3    ctermbg=NONE guifg=Yellow   guibg=NONE
hi Typedef          ctermfg=3    ctermbg=NONE guifg=Yellow   guibg=NONE

" Reset Generic Keywords & Statements -> Default FG
hi Keyword          ctermfg=NONE ctermbg=NONE guifg=NONE     guibg=NONE
hi Statement        ctermfg=NONE ctermbg=NONE guifg=NONE     guibg=NONE
hi Type             ctermfg=4    ctermbg=NONE guifg=Blue     guibg=NONE
hi PreProc          ctermfg=NONE ctermbg=NONE guifg=NONE     guibg=NONE
hi Special          ctermfg=NONE ctermbg=NONE guifg=NONE     guibg=NONE
hi Delimiter        ctermfg=8    ctermbg=NONE guifg=DarkGray guibg=NONE

" HTML Tags
hi Tag              ctermfg=4    ctermbg=NONE guifg=Blue     guibg=NONE

" Markdown Headings
hi Title            ctermfg=1    ctermbg=NONE guifg=Red      guibg=NONE
