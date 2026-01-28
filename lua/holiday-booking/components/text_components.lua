--- Text components wrapper for Segment
--- @class holiday-booking.components.TextComponents
local TextComponents = {}

-- Import individual components
TextComponents.Separator = require("holiday-booking.components.separator")
TextComponents.Header = require("holiday-booking.components.header")
TextComponents.Label = require("holiday-booking.components.label")
TextComponents.Text = require("holiday-booking.components.text")
TextComponents.InputField = require("holiday-booking.components.input_field")
TextComponents.StatusMessage = require("holiday-booking.components.status_message")

return TextComponents
