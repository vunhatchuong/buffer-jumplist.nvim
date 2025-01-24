local Config = require("buffer-jumplist.config").options

local M = {}

--- Filter based on opts
---
---@param lines NuiTree.Node[]
---@return NuiTree.Node[] results
function M.filter(lines)
    local result = {} ---@type NuiTree.Node[]

    if Config.line_distance_threshold then
        for _, item in ipairs(lines) do
            if item.jump then
                local should_add = true

                local lnum = item.jump.lnum
                for _, added_jump in ipairs(result) do
                    if math.abs(lnum - added_jump.jump.lnum) <= Config.line_distance_threshold then
                        should_add = false
                        break
                    end
                end

                if should_add then
                    table.insert(result, item)
                end
            end
        end
    else
        result = { unpack(lines) }
    end

    if Config.max_result and #result > Config.max_result then
        result = vim.list_slice(result, 1, Config.max_result)
    end

    return result
end

---@class BufferJumplistMainWinState
M.state = {}

function M.main_win_state()
    M.state.win_id = vim.api.nvim_get_current_win()
    M.state.bufnr = vim.api.nvim_get_current_buf()
    M.state.cursor_pos = vim.api.nvim_win_get_cursor(0)
end

function M.get_state()
    return M.state
end

return M
