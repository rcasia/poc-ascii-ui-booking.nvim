--- Label component - form label
--- @class holiday-booking.components.Label
local ui = require("ascii-ui")
local Segment = require("ascii-ui.buffer.segment")

--- Label component function
--- @param props { content: string, color?: table }
--- @return table
local function LabelComponent(props)
	props = props or {}
	local content = props.content
	local color = props.color or { fg = "#87CEEB" }
	return {
		Segment:new({
			content = content,
			color = color,
		}):wrap()
	}
end

return ui.createComponent("Label", LabelComponent, {
	content = "string",
})
