--- Text component - generic text with customizable color
--- @class holiday-booking.components.Text
local ui = require("ascii-ui")
local Segment = require("ascii-ui.buffer.segment")

--- Text component function
--- @param props { content: string, color?: table }
--- @return table
local function TextComponent(props)
	props = props or {}
	local content = props.content
	local color = props.color or { fg = "#E0E0E0" }
	return {
		Segment:new({
			content = content,
			color = color,
		}):wrap()
	}
end

return ui.createComponent("Text", TextComponent, {
	content = "string",
})
