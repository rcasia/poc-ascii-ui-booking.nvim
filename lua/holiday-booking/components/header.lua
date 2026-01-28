--- Header component - main title
--- @class holiday-booking.components.Header
local ui = require("ascii-ui")
local Segment = require("ascii-ui.buffer.segment")

--- Header component function
--- @param props { content: string, color?: table }
--- @return table
local function HeaderComponent(props)
	props = props or {}
	local content = props.content
	local color = props.color or { fg = "#FFD700" }
	return {
		Segment:new({
			content = content,
			color = color,
		}):wrap()
	}
end

return ui.createComponent("Header", HeaderComponent, {
	content = "string",
})
