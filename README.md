# it-compiles.lua

Send compilation errors to quickfix list.

## Installation

### lazyvim

```lua
return {
  "EthanJWright/it-compiles.nvim",
  config = function()
    require("it-compiles").setup({
      command = {
        ts = "npm run tsc",
      },
    })
  end,
}
```

## Usage

```lua
map("n", "<leader>cm", function()
  require("it-compiles").check()
end, { desc = "Build Typescript and see errors" })
```
