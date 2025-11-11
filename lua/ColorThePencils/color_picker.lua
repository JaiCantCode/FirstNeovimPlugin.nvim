local telescope = require('telescope')
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require("telescope.config").values


function write_color_file(buffer)
    local file_to_write = io.open("lua/FirstNeovimPlugin/last_color.txt","w")

    if file_to_write then
        file_to_write:write(buffer)
        file_to_write:close()
    else
        print("Error finding file!!")
    end
end

function read_color_file()
    local file_to_read = io.open("lua/FirstNeovimPlugin/last_color.txt","r")

    if file_to_read then
        local color = file_to_read:read("*all")
        file_to_read:close()
        return color
    else
        print("Error finding file!!")
    end
    return nil
end

local colorwhichpencils = function (opts)
    opts = opts or {}
 
    local function colorthempencils(sel)
        write_color_file(sel[1])
        read_color_file()
        vim.cmd('colorscheme ' .. sel[1])
    end
    local function next_color(bufnr)
        actions.move_selection_next(bufnr)
        local selected = action_state.get_selected_entry()
        colorthempencils(selected)
    end
    local function prev_color(bufnr)
        actions.move_selection_previous(bufnr)
        local selected = action_state.get_selected_entry()
        colorthempencils(selected)
    end


    pickers.new(opts, {
        prompt_title = "Choose Which Pencil",
        finder = finders.new_table(vim.fn.getcompletion("", "color")),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(bufnr, map)
            actions.select_default:replace(function()
                actions.close(bufnr)
                local selection = action_state.get_selected_entry()
                colorthempencils(selection)
                current_color = selection
            end)
            map( "i", "<Down>", next_color)
            map( "i", "<Up>", prev_color)

            return true
        end,
        layout_config = {
            width = 0.15,   -- 15% of the editor width
            height = 0.8,   -- 80% of the editor height
            prompt_position = "top",
            anchor = "E",
        },
    }):find()
end

function ColorWhichPencils()
    colorwhichpencils()
end


