--- Header component - main title with separators
--- @class holiday-booking.components.Header
local ui = require("ascii-ui")
local Segment = require("ascii-ui.buffer.segment")
local Separator = require("holiday-booking.components.separator")

--- Header component function
--- @param props { content: string, color?: table, separatorColor?: table }
--- @return table
local function HeaderComponent(props)
	props = props or {}
	local content = props.content
	local color = props.color or { fg = "#FFD700" }
	local separatorColor = props.separatorColor or { fg = "#4ECDC4" }
	
	return {
		Separator({ color = separatorColor }),
		Segment:new({
			content = content,
			color = color,
		}):wrap(),
		Separator({ color = separatorColor }),
	}
end

return ui.createComponent("Header", HeaderComponent, {
	content = "string",
})
