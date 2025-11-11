
function TransparentMyPencils()

    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal"})
    local normal_transparent = normal_hl and normal_hl.bg == nil

    if normal_transparent then
        vim.cmd.colorscheme(vim.g.colors_name)
    else
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalSB", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "none", bg = "none" })
    end
end

