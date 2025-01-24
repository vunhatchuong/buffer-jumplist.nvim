---@class BufferJumplist
local M = {}

---@param user_opts? BufferJumplistConfig
function M.setup(user_opts)
    local Config = require("buffer-jumplist.config")
    Config.setup(user_opts)

    local nui = require("buffer-jumplist.nui")
    nui.setup()
end

return M
