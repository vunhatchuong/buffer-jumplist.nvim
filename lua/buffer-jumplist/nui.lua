local Menu = require("nui.menu")
local Event = require("nui.utils.autocmd").event

local Core = require("buffer-jumplist.core")
local Jumplist = require("buffer-jumplist.jumplist")

local M = {}

function M.create_menu()
    local jumplist = vim.fn.getjumplist()[1]
    local lines = Jumplist.lines(jumplist)

    return Menu({
        position = "50%",
        -- anchor = "NE",
        -- position = { row = 0, col = vim.api.nvim_win_get_width(0) },
        zindex = 200,
        border = {
            style = "single",
            text = {
                top = "[Jumplist]",
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    }, {
        lines = lines,
        max_width = 50,
        keymap = {
            focus_next = { "j", "l", "<Down>", "<C-o>", "<Tab>" },
            focus_prev = { "k", "h", "<Up>" },
            close = { "<Esc>", "<C-c>", "q" },
            submit = { "<CR>", "<Space>" },
        },
        on_change = Jumplist.on_change,
        on_close = Jumplist.on_close,
        on_submit = Jumplist.on_submit,
    })
end

function M.setup()
    vim.api.nvim_create_user_command("BufferJumplist", function()
        local menu = M.create_menu()
        menu:on(Event.BufLeave, function()
            vim.api.nvim_buf_clear_namespace(1, require("buffer-jumplist.jumplist").ns, 0, -1)
            menu:unmount()
        end)
        Core.main_win_state()
        menu:mount()
    end, {})
end

return M
