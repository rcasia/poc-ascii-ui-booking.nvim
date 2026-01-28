# holiday-booking.nvim

A proof-of-concept example showcasing **ascii-ui.nvim** features for building interactive terminal UIs in Neovim.

## Overview

This project demonstrates how to use ascii-ui.nvim to create a complete, interactive holiday booking interface with navigation, state management, and custom components.

## ascii-ui.nvim Features Showcased

### 1. Component System (`ui.createComponent`)

Create reusable, composable components with prop validation:

```lua
local ui = require("ascii-ui")
local function MyComponent(props)
  return { -- return list of bufferlines }
end

return ui.createComponent("MyComponent", MyComponent, {
  propName = "string",  -- required prop
  optionalProp = "string?",  -- optional prop (not supported, omit from schema)
})
```

**Example in this project:**
- `WelcomePage`, `SearchPage`, `BookingsPage` - Page components
- `Offer`, `OfferList`, `BookingList` - List components
- `Header`, `Label`, `Text`, `Separator` - Text components

### 2. Built-in Components (`ui.components`)

Use pre-built components for common UI elements:

```lua
local Paragraph = ui.components.Paragraph
local Button = ui.components.Button

return {
  Paragraph({ content = "" }),  -- Empty line for spacing
  Button({
    label = "Click Me",
    on_press = function()
      -- Handle button click
    end,
  }),
}
```

**Example in this project:**
- `Paragraph` - Used throughout for spacing
- `Button` - Used for navigation and actions (Search, Book, Delete, etc.)

### 3. State Management (`ui.hooks.useState`)

Manage component state reactively:

```lua
local useState = ui.hooks.useState

local function MyComponent(props)
  local count, setCount = useState(0)
  
  return {
    Button({
      label = "Count: " .. count,
      on_press = function()
        setCount(count + 1)  -- Triggers re-render
      end,
    }),
  }
end
```

**Example in this project:**
- Page navigation state (`currentPage`)
- Form inputs (`startDate`, `endDate`, `description`)
- Search results and loading states
- Booking list state

### 4. Custom Segments (`ascii-ui.buffer.segment`)

Create custom text segments with colors and styling:

```lua
local Segment = require("ascii-ui.buffer.segment")

return {
  Segment:new({
    content = "Hello World",
    color = { fg = "#FFD700", bg = "#1a1a2e" },
  }):wrap()
}
```

**Example in this project:**
- `Header`, `Label`, `Text`, `Separator` components use `Segment` for styled text
- Custom colors for different UI elements (headers, labels, prices, etc.)

### 5. Component Composition

Components return lists of bufferlines, allowing easy composition:

```lua
local function ParentComponent(props)
  return {
    Header({ content = "Title" }),
    Paragraph({ content = "" }),
    ChildComponent({ data = props.data }),  -- Nest components
    Paragraph({ content = "" }),
  }
end
```

**Example in this project:**
- Pages compose multiple components (Header, Buttons, Lists)
- Lists compose individual item components
- Custom text components wrap Segment for reuse

### 6. Application Mounting (`ui.mount`)

Mount the root component to display the UI:

```lua
local App = ui.createComponent("App", AppComponent)
ui.mount(App)
```

**Example in this project:**
- `HolidayBookingApp` is the root component mounted in `UI.open()`

### 7. Custom Hooks

Create reusable hooks for shared logic:

```lua
local useState = require("ascii-ui.hooks.use_state")

function useCustomHook()
  local state, setState = useState(initialValue)
  -- Custom logic
  return state, setState, otherFunctions
end
```

**Example in this project:**
- `useOffersSearch` - Custom hook for search functionality with loading state

## Project Structure

```
lua/holiday-booking/
├── components/          # Reusable UI components
│   ├── header.lua      # Header with separators (uses Segment)
│   ├── label.lua       # Form labels (uses Segment)
│   ├── text.lua        # Text display (uses Segment)
│   ├── separator.lua   # Decorative lines (uses Segment)
│   ├── welcome_page.lua
│   ├── search_page.lua
│   ├── bookings_page.lua
│   └── ...
├── hooks/
│   └── use_offers_search.lua  # Custom hook example
└── ui.lua              # Root component and mounting
```

## Key Patterns Demonstrated

1. **Component-based Architecture**: Each UI element is a reusable component
2. **State Management**: React-like state hooks for reactive updates
3. **Navigation**: Multi-page app with state-driven page switching
4. **Custom Styling**: Segment-based components for consistent styling
5. **Composition**: Small components compose into larger pages
6. **Hooks**: Custom hooks for shared stateful logic

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
-- Open the holiday booking interface
:HolidayBooking

-- Or from Lua
require("holiday-booking").open()
```

## Learn More

This project serves as a comprehensive example of ascii-ui.nvim capabilities. Explore the code to see:
- How to structure a multi-page application
- How to manage state across components
- How to create custom styled components
- How to compose complex UIs from simple building blocks
