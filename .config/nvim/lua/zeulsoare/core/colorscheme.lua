vim.g.zeulsoare_colorscheme = "gruvbox-material"

-- Everforest theme configuration
if vim.g.zeulsoare_colorscheme == "everforest" then
    -- configuration options can be found here:
    -- https://github.com/sainnhe/everforest/blob/master/doc/everforest.txt 
    vim.g.everforest_background = 'hard'
    vim.g.everforest_better_performace = 1
    vim.g.everforest_ui_contrast = "high"
    vim.g.everforest_transparent_background = 1
elseif vim.g.zeulsoare_colorscheme == "gruvbox-material" then
    -- configuration options can be found here:
    -- https://github.com/sainnhe/gruvbox-material/blob/master/doc/gruvbox-material.txt
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_better_performace = 1
    vim.g.gruvbox_material_ui_contrast = "high"
    vim.g.gruvbox_material_transparent_background = 1
end

local status, _ = pcall(vim.cmd, "colorscheme " .. vim.g.zeulsoare_colorscheme)
if not status then
    print(string.format("Color scheme %s not found!", colorscheme))
    --- Make window transparent for colorschemes that do no have it build in
    vim.cmd([[highlight Normal guibg=none]])
    vim.cmd([[highlight NonText guibg=none]])
    return
end

