--- StatusMessage component - status/info message
--- @class holiday-booking.components.StatusMessage
local ui = require("ascii-ui")
local Segment = require("ascii-ui.buffer.segment")

--- StatusMessage component function
--- @param props { content: string, color?: table }
--- @return table
local function StatusMessageComponent(props)
	props = props or {}
	local content = props.content
	local color = props.color or { fg = "#4ECDC4" }
	return {
		Segment:new({
			content = content,
			color = color,
		}):wrap()
	}
end

return ui.createComponent("StatusMessage", StatusMessageComponent, {
	content = "string",
})
