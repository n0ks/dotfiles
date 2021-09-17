set termguicolors
" let g:embark_terminal_italics = 1
" let g:gruvbox_material_enable_italic = 1
" let g:gruvbox_material_transparent_background = 1
" let g:gruvbox_material_better_performance = 1
" let g:tokyonight_style = "night"
" let g:tokyonight_transparent = 1             
" colorscheme embark
" colorscheme nightfly
" colorscheme gruvbox-material


lua << EOF
local catppuccino = require("catppuccino")

-- configure it
catppuccino.setup(
    {
    colorscheme = "neon_latte",
    transparency = false,
    term_colors = true,
		styles = {
			comments = "italic",
			functions = "italic",
			keywords = "italic",
			strings = "NONE",
			variables = "NONE",
		},
		integrations = {
			treesitter = true,
			native_lsp = {
				enabled = true,
				styles = {
					errors = "italic",
					hints = "italic",
					warnings = "italic",
					information = "italic"
				}
			},
			lsp_trouble = false,
			lsp_saga = true,
			gitgutter = false,
			gitsigns = true,
			telescope = true,
			nvimtree = {
				enabled = false,
				show_root = false,
			},
			which_key = false,
			indent_blankline = false,
			dashboard = false,
			neogit = false,
			vim_sneak = false,
			fern = true,
			barbar = false,
			bufferline = false,
			markdown = false,
		}
	}
)

-- load it
catppuccino.load()
EOF

" hi! Normal ctermbg=NONE guibg=NONE
" hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

" hi! Normal ctermbg=NONE guibg=NONE
" hi! NonText ctermbg=NONE guibg=NONE
