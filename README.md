# it-compiles.lua

Neovim plugin to check compilation status of code in background, and send to quickfix list on failure

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
