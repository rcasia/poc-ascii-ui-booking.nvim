# holiday-booking.nvim

Neovim plugin for managing and booking holidays (POC).

## Description

This is a proof of concept plugin that allows you to manage and book holidays directly from Neovim using ascii-ui.

## Installation

```lua
-- With lazy.nvim
{
  "rcasia/holiday-booking.nvim",
  dependencies = {
    "rcasia/ascii-ui.nvim"
  },
  config = function()
    require("holiday-booking").setup()
  end
}
```

## Usage

```lua
-- Open the holiday booking panel
:HolidayBooking

-- Or from Lua
require("holiday-booking").open()
```

## Features

- [ ] Date selection interface
- [ ] Calendar visualization
- [ ] Booking management
- [ ] ascii-ui integration

## Status

🚧 In development - POC
