--- Separator component - decorative line
--- @class holiday-booking.components.Separator
local ui = require("ascii-ui")
local Segment = require("ascii-ui.buffer.segment")

--- Separator component function
--- @param props { content?: string, color?: table }
--- @return table
local function SeparatorComponent(props)
	props = props or {}
	local content = props.content or "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	local color = props.color or { fg = "#4ECDC4" }
	return {
		Segment:new({
			content = content,
			color = color,
		}):wrap()
	}
end

return ui.createComponent("Separator", SeparatorComponent, {})
