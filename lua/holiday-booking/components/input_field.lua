--- InputField component - editable input field
--- @class holiday-booking.components.InputField

local ui = require("ascii-ui")
local Segment = require("ascii-ui.buffer.segment")
local interaction_type = require("ascii-ui.interaction_type")

--- InputField component function
--- @param props { value: string, placeholder?: string, onInput?: function, color?: table, bg?: table }
--- @return table
local function InputFieldComponent(props)
	props = props or {}
	local value = props.value or ""
	local placeholder = props.placeholder or ""
	local onInput = props.onInput or function() end
	local displayValue = value ~= "" and value or placeholder
	local color = props.color or { fg = "#FFD700", bg = "#1a1a1a" }
	
	return {
		Segment:new({
			content = displayValue,
			is_focusable = true,
			color = color,
			interactions = {
				[interaction_type.ON_INPUT] = onInput,
			},
		}):wrap()
	}
end

return ui.createComponent("InputField", InputFieldComponent, {
	value = "string",
})
