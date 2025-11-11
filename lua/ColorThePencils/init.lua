local m = {}
local cp = require("FirstNeovimPlugin.color_picker")
local tp = require("FirstNeovimPlugin.transparency_picker")


local current_color = read_color_file() or "gruvbox"
vim.cmd.colorscheme(current_color)

vim.api.nvim_create_user_command('ColorWhichPencils', function()
    ColorWhichPencils()
end, {})

vim.api.nvim_create_user_command('TransparentMyPencils', function ()
    TransparentMyPencils()
end, {})

vim.keymap.set("n", "<leader>cwp", vim.cmd.ColorWhichPencils)
vim.keymap.set("n", "<leader>tmp", vim.cmd.TransparentMyPencils)


return m
