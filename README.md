# buffer-jumplist.nvim

Show jump locations of current buffer in a floating window.

![image](https://github.com/user-attachments/assets/eb55c7ee-bf90-4754-b238-ea52f3eb22c1)


## Installation

### lazy.nvim

```lua
{
    "vunhatchuong/buffer-jumplist.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = { { "<C-o>", "<CMD>BufferJumplist<CR>" } },
    opts = {
        -- max_result = 5,
        line_distance_threshold = 3,
    },
}
```

## Configuration

These are the default values, you can view it directly in [config.lua](./lua/buffer-jumplist/config.lua).

```lua
{
    ---@type integer? The maximum number of jump results to display.
    max_result = nil,

    ---@type integer? The minimum distance between lines to consider as separate jumps.
    line_distance_threshold = nil,
}
```
