local M = {}

---@class BufferJumplistConfig
M.defaults = {
    ---@type integer? The maximum number of jump results to display.
    max_result = nil,

    ---@type integer? The minimum distance between lines to consider as separate jumps. If set to 2, it will exclude jumps within 2 lines of each other.
    line_distance_threshold = nil,
}

---@class BufferJumplistConfig
M.options = {}

--- Merge defaults with user opts
---
---@param user_opts? BufferJumplistConfig
M.setup = function(user_opts)
    M.options = vim.tbl_deep_extend("force", M.defaults, user_opts or {})
end

return M
