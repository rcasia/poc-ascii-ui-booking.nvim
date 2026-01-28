--- @class holiday-booking.HolidayBooking
local HolidayBooking = {}

local config = {
	-- Default configuration
}

local ui = require("holiday-booking.ui")

--- Setup function
--- @param opts table|nil
function HolidayBooking.setup(opts)
	opts = opts or {}
	config = vim.tbl_deep_extend("force", config, opts)
end

--- Open the holiday booking interface
function HolidayBooking.open()
	ui.open()
end

--- Create a command to open the holiday booking interface
vim.api.nvim_create_user_command("HolidayBooking", function()
	HolidayBooking.open()
end, {
	desc = "Open the holiday booking panel",
})

return HolidayBooking
