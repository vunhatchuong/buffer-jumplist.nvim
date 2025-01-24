local Menu = require("nui.menu")
local NuiLine = require("nui.line")

local M = {}

local MainWinState = require("buffer-jumplist.core").get_state()

M.ns = vim.api.nvim_create_namespace("buffer-jumplist")

---@param jumplist vim.fn.getjumplist.ret.item[]
---@return NuiTree.Node[] lines
function M.lines(jumplist)
    local current_buffer = vim.fn.winbufnr(vim.fn.win_getid())

    local lines = {} ---@type NuiTree.Node[]

    for _, jump in ipairs(jumplist) do
        if current_buffer == jump.bufnr then
            local line = vim.api.nvim_buf_get_lines(jump.bufnr, jump.lnum - 1, jump.lnum, false)[1]
            if line then
                local nuiline = NuiLine()
                nuiline:append(string.format("%d:%-4d ", jump.lnum, jump.col + 1), "Directory")
                nuiline:append(string.format("%s", line), "Comment")

                table.insert(lines, 1, Menu.item(nuiline, { jump = jump }))
            end
        end
    end

    lines = require("buffer-jumplist.core").filter(lines)

    return lines
end

---@param item NuiTree.Node The selected item
---@param menu NuiMenu The menu state
function M.on_change(item, menu)
    local jump = item.jump

    vim.api.nvim_buf_clear_namespace(MainWinState.bufnr, M.ns, 0, -1)
    vim.api.nvim_buf_set_extmark(MainWinState.bufnr, M.ns, jump.lnum - 1, 0, {
        hl_mode = "combine",
        line_hl_group = "Visual",
    })

    vim.api.nvim_win_set_cursor(MainWinState.win_id, { jump.lnum, jump.col })
end

function M.on_close()
    vim.api.nvim_buf_clear_namespace(MainWinState.bufnr, M.ns, 0, -1)
    vim.api.nvim_win_set_cursor(0, MainWinState.cursor_pos)
    vim.cmd("norm! zzzv")
end

---@param item NuiTree.Node The selected item
function M.on_submit(item)
    local jump = item.jump

    vim.api.nvim_buf_clear_namespace(MainWinState.bufnr, M.ns, 0, -1)
    vim.api.nvim_win_set_cursor(0, { jump.lnum, jump.col })
    vim.cmd("norm! zzzv")
end

return M
