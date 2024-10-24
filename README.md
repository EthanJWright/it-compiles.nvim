# it-compiles.lua

Send compilation errors to quickfix list.

## Installation

### lazyvim

```lua
return {
  "EthanJWright/it-compiles.nvim",
}
```

## Usage

```lua
map("n", "<leader>cm", function()
  local it_compiles = require("it-compiles")
  it_compiles.check()
end, { desc = "Build Typescript and see errors" })
```
