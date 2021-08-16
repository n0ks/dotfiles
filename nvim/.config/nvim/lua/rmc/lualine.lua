require'lualine'.setup{
  extensions = {'quickfix','fugitive'},
  options = {
    theme  = 'gruvbox-flat' ,
    -- theme  = 'nightfly' ,
    -- theme  = 'palenight' ,
    -- theme  = 'material-nvim' ,
    section_separators = '', 
    component_separators = '⁃'
  },
    sections = {
    lualine_a = { 'mode'},
    lualine_b = {'branch'},
    lualine_c = {'diagnostics'},
    lualine_x = {'g:coc_status','filetype'}
    },
}



